import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/core/cache_helper.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final email = TextEditingController();
  final password = TextEditingController();
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
        CacheHelper.saveName(value.docs[0].data()['name']);
        CacheHelper.saveId(value.docs[0].data()['uid']);
        CacheHelper.savePhone(value.docs[0].data()['phone']);
        CacheHelper.saveEmail(value.docs[0].data()['email']);
      });

      emit(LoginSuccessState(message:'Login success'));
    } on FirebaseAuthException catch(e){
      emit(LoginFailureState(message: e.message?? "error!"));
    }
  }
}
