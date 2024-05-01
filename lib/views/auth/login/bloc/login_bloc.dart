import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final email = TextEditingController(text: 'b@gmail.com');
  final password = TextEditingController(text: '123456');
  final formKey=GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  LoginBloc() : super(LoginInitial()) {
    on<LoginNowEvent>(loginNow);
  }

  FutureOr<void> loginNow(LoginNowEvent event, Emitter<LoginState> emit)async{
    try{
      emit(LoginLoadingState());
      final user= await FirebaseAuth.instance.signInWithEmailAndPassword(email: event.email, password: event.password);
      await FirebaseFirestore.instance.collection('Users').where('uid',isEqualTo: user.user!.uid).get().then((value) {
        // PrefUtils.setName(value.docs[0].data()['name']);
        // PrefUtils.setCity(value.docs[0].data()['city']);
        // PrefUtils.setEmail(value.docs[0].data()['email']);
        // PrefUtils.setPhone(value.docs[0].data()['phone']);
        // PrefUtils.setUid(value.docs[0].data()['uid']);
      });

      emit(LoginSuccessState(message:'Login success'));
    } on FirebaseAuthException catch(e){
      emit(LoginFailureState(message: e.message?? "error!"));
    }
  }
}
