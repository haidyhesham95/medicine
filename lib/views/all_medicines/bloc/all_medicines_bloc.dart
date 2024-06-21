import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/lang/manager/lang_cubit.dart';
import 'package:pharmacy/views/all_medicines/model/medicine_model.dart';

import '../../../core/translate.dart';

part 'all_medicines_event.dart';

part 'all_medicines_state.dart';



class AllMedicinesBloc extends Bloc<AllMedicinesEvent, AllMedicinesState> {
  final FirebaseFirestore ins = FirebaseFirestore.instance;

  AllMedicinesBloc() : super(AllMedicinesInitial()) {
    on<GetAllMedicinesEvent>((event, emit) => getAllMedicines(event, emit, event.context));
   // on<RequestMedicineEvent>(requestMedicine);
  }
  Future<String> mockTranslate(String text) async {
    await Future.delayed(Duration(milliseconds: 50));
   return Translate.translate(text);
  }


  FutureOr<void> getAllMedicines(GetAllMedicinesEvent event, Emitter<AllMedicinesState> emit, BuildContext context) async {
    List<MedicineModel> medicines = [];
    emit(GetAllMedicinesLoadingState());

    try {
      final querySnapshot = await FirebaseFirestore.instance.collection("medicines").get();

      for (var element in querySnapshot.docs) {
        Map<String, dynamic> medicineMap;
        if (LangCubit.get(context).appLocale == const Locale('en')) {
          medicineMap = element.data() as Map<String, dynamic>;
        } else {
          medicineMap = {
            'name': await mockTranslate(element.data()['name']),
            'description': await mockTranslate(element.data()['description']),
            'price': element.data()['price'],
            'image': element.data()['image'],
            'location': element.data()['location'] != null ? await mockTranslate(element.data()['location']) : null,
          };
        }
        medicines.add(MedicineModel.fromJson(medicineMap, element.id));
      }

      emit(GetAllMedicinesSuccessState(medicines: medicines));
    } on FirebaseException catch (e) {
      emit(GetAllMedicinesFailureState(message: e.code));
    }
  }


  // FutureOr<void> getAllMedicines(GetAllMedicinesEvent event, Emitter<AllMedicinesState> emit) async{
  //   try{
  //     emit(GetAllMedicinesLoadingState());
  //     final data=await ins.collection('medicines').get();
  //     List<MedicineModel> result=[];
  //     if(data.docs.isEmpty){
  //       emit(GetAllMedicinesFailureState(message: 'No products yet'));
  //     }else{
  //       for(int i=0; i<data.docs.length;i++){
  //         result.add(MedicineModel.fromJson(data.docs[i].data(),data.docs[i].id));
  //       }
  //       emit(GetAllMedicinesSuccessState(medicines: result));
  //     }
  //
  //   }on FirebaseException catch(e){
  //     emit(GetAllMedicinesFailureState(message: e.code));
  //
  //   }
  // }


// FutureOr<void> requestMedicine(RequestMedicineEvent event, Emitter<AllMedicinesState> emit) async{
//   try{
//     emit(RequestMedicineLoadingState());
//     ins.collection('requests').add({
//       "medicineId":event.medicineId,
//       "userId":event.userId
//     });
//     emit(RequestMedicineSuccessState(message: 'Request Sent successfully'));
//   }on FirebaseException catch(e){
//     emit(RequestMedicineFailureState(message: e.code));
//   }
// }
}
