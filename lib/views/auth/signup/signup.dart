import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pharmacy/core/helper_methods.dart';
import 'package:pharmacy/views/all_medicines/all_medicines.dart';
import 'package:pharmacy/views/auth/signup/bloc/signup_bloc.dart';
import 'package:pharmacy/wrapper.dart';

class SignUpScreen extends StatelessWidget {
  final bloc = KiwiContainer().resolve<SignupBloc>();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
          child: Form(
            key: bloc.formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 100.h,
                ),
                Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                ),
                 SizedBox(
                  height: 30.h,
                ),
                TextFormField(
                  controller: bloc.name,
                  validator: (value) {
                    if (value == '') {
                      return 'please enter your name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r))),
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextFormField(
                  controller: bloc.phone,
                  validator: (value) {
                    if (value == '') {
                      return 'please enter your phone number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r))),
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextFormField(
                  controller: bloc.email,
                  validator: (value) {
                    if (value == '') {
                      return 'please enter your email address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r))),
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextFormField(
                  controller: bloc.password,
                  validator: (value) {
                    if (value == '') {
                      return 'please enter password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r))),
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextFormField(
                  controller: bloc.confirmPassword,
                  validator: (value) {
                    if (value == '') {
                      return 'Enter your password';
                    } else if (value != bloc.password.text) {
                      return 'Invalid password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r))),
                ),
                SizedBox(
                  height: 16.h,
                ),
                BlocListener(
                  bloc: bloc,
                  listener: (context, state) {
                    if(state is SignupSuccessState){
                      toast(msg: state.message);
                      navigateTo(context, page: Wrapper());
                    }else if(state is SignupFailureState){
                      toast(msg: state.message);
                    }
                  },
                  child: ElevatedButton(
                      onPressed: () {
                        if (bloc.formKey.currentState!.validate()) {
                          bloc.add(SignupNowEvent(
                              name: bloc.name.text,
                              email: bloc.email.text,
                              password: bloc.password.text,
                              phone: bloc.phone.text));
                        }
                      },
                      child: const Text('Sign Up')),
                ),
                SizedBox(
                  height: 16.h,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Have Account',
                        style: TextStyle(color: Colors.black, fontSize: 14.sp)),
                    TextSpan(
                        text: ' Login',
                        style: TextStyle(color: Colors.blue, fontSize: 16.sp)),
                  ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
