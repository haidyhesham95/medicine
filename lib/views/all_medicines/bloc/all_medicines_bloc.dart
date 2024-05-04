import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:pharmacy/views/all_medicines/model/medicine_model.dart';

part 'all_medicines_event.dart';
part 'all_medicines_state.dart';

class AllMedicinesBloc extends Bloc<AllMedicinesEvent, AllMedicinesState> {
  final ins=FirebaseFirestore.instance.collection('medicines');
  AllMedicinesBloc() : super(AllMedicinesInitial()) {
    on<GetAllMedicinesEvent>(getAllMedicines);
  }
  FutureOr<void> getAllMedicines(GetAllMedicinesEvent event, Emitter<AllMedicinesState> emit) async{
    try{
      emit(GetAllMedicinesLoadingState());
      final data=await ins.get();
      List<MedicineModel> result=[];
      if(data.docs.isEmpty){
        emit(GetAllMedicinesFailureState(message: 'No products yet'));
      }else{
        for(int i=0; i<data.docs.length;i++){
          result.add(MedicineModel.fromJson(data.docs[i].data()));
        }
        emit(GetAllMedicinesSuccessState(medicines: result));
      }

    }on FirebaseException catch(e){
      emit(GetAllMedicinesFailureState(message: 'something went wrong'));
    }
  }
}
