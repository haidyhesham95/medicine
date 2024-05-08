import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/core/cache_helper.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final formKey=GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  SignupBloc() : super(SignupInitial()) {
    on<SignupNowEvent>(signup);
  }

  FutureOr<void> signup(SignupNowEvent event, Emitter<SignupState> emit)async{
    try {
      emit(SignupLoadingState());
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      if (user.user != null) {
        FirebaseFirestore.instance.collection('Users').add({
          'name': name.text,
          'phone': phone.text,
          'email': email.text,
          'uid': user.user!.uid,
        });
        CacheHelper.saveName(name.text);
        CacheHelper.saveId(user.user!.uid);
        CacheHelper.savePhone(phone.text);
        CacheHelper.saveEmail(email.text);
        emit(SignupSuccessState(message: 'Account Created successfully'));
      } else {
        emit(SignupFailureState(message: "error!"));
      }
    } on FirebaseAuthException catch (e) {
      emit(SignupFailureState(message: e.message ?? "error!"));
    }
  }
}
