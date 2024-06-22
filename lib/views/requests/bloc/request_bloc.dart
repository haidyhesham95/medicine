import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/views/all_medicines/model/medicine_model.dart';
import 'package:pharmacy/views/requests/model/request_model.dart';

import '../../../core/translate.dart';
import '../../../lang/manager/lang_cubit.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final ins = FirebaseFirestore.instance;

  RequestBloc() : super(RequestInitial()) {


    on<GetAllRequestsEvent>((event, emit) => getAllRequests(event, emit, event.context));

    on<RequestMedicineEvent>(requestMedicine);
    on<DeleteRequestMedicineEvent>(deleterequestMedicine);
  }


  Future<String> mockTranslate(String text) async {
    await Future.delayed(Duration(milliseconds: 50));
    return Translate.translate(text);
  }


  FutureOr<void> requestMedicine(RequestMedicineEvent event,
      Emitter<RequestState> emit) async {
    try {
      emit(RequestMedicineLoadingState());
      ins
          .collection('requests')
          .add({"medicineId": event.medicineId, "userId": event.userId});
      emit(RequestMedicineSuccessState(message: 'Request Sent successfully'));
    } on FirebaseException catch (e) {
      emit(RequestMedicineFailureState(message: e.code));
    }
  }

  FutureOr<void> deleterequestMedicine(DeleteRequestMedicineEvent event,
      Emitter<RequestState> emit) async {
    try {
      ins.collection('requests').doc(event.requestid).delete();
      // emit(RequestMedicineSuccessState(message: 'Request Sent successfully'));
    } on FirebaseException catch (e) {}
  }

  FutureOr<void> getAllRequests(
      GetAllRequestsEvent event, Emitter<RequestState> emit, BuildContext context) async {
    try {
      emit(GetAllRequestsLoadingState());
      final requests = await ins.collection('requests').get();
      List<RequestModel> request = [];
      for (int i = 0; i < requests.docs.length; i++) {
        final user = await getUserWithTranslation(requests.docs[i].data()['userId'],event.context);
        final medicine = await getMedicineWithTranslation(requests.docs[i].data()['medicineId'],event.context);
        request.add(RequestModel(
            medicine: medicine, user: user, id: requests.docs[i].id));
      }
      emit(GetAllRequestsSuccessState(requests: request));
    } on FirebaseException catch (e) {
      emit(GetAllRequestsFailureState(message: e.code));
    }
  }

  FutureOr<MedicineModel> getMedicineWithTranslation(String medicineId,context) async {
    final data = await ins.collection('medicines').doc(medicineId).get();
    Map<String, dynamic> medicineMap = data.data()!;
    if (LangCubit.get(context).appLocale != const Locale('en')) {
      medicineMap['name'] = await mockTranslate(medicineMap['name']);
      medicineMap['description'] = await mockTranslate(medicineMap['description']);
      // Translate other fields if needed
    }
    return MedicineModel.fromJson(medicineMap, medicineId);
  }

  FutureOr<UserModel> getUserWithTranslation(String userId,context) async {
    final data = await ins.collection('Users').where('uid', isEqualTo: userId).get();
    Map<String, dynamic> userMap = data.docs[0].data();
    if (LangCubit.get(context).appLocale != const Locale('en')) {
      userMap['name'] = await mockTranslate(userMap['name']);
      // Translate other fields if needed
    }
    return UserModel.fromJson(userMap);
  }

}