import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pharmacy/views/add_medicine/bloc/add_medicine_bloc.dart';
import 'package:pharmacy/views/all_medicines/bloc/all_medicines_bloc.dart';
import 'package:pharmacy/views/auth/login/bloc/login_bloc.dart';
import 'package:pharmacy/views/auth/signup/bloc/signup_bloc.dart';
import 'package:pharmacy/views/requests/bloc/request_bloc.dart';


Future<void> initKiwi() async {
  KiwiContainer container = KiwiContainer();
  container.registerFactory((container) => LoginBloc());
  container.registerFactory((container) => SignupBloc());
  container.registerFactory((container) => AddMedicineBloc());
  container.registerSingleton((container) => AllMedicinesBloc());
  container.registerSingleton((container) => RequestBloc());


}
