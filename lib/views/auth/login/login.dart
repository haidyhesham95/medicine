import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pharmacy/core/helper_methods.dart';
import 'package:pharmacy/views/add_medicine/add_medicine.dart';
import 'package:pharmacy/views/all_medicines/all_medicines.dart';
import 'package:pharmacy/views/auth/login/bloc/login_bloc.dart';
import 'package:pharmacy/views/auth/signup/signup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/wrapper.dart';


class LoginScreen extends StatelessWidget {
  final bloc = KiwiContainer().resolve<LoginBloc>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
          child: Form(
            key: bloc.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: bloc.email,
                  validator: (value) {
                    if(value==''){
                      return 'please enter email address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: bloc.password,
                  obscureText: true,
                  validator: (value) {
                    if(value==''){
                      return 'please enter password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocListener(
                  bloc:bloc,
                  listener: (context, state) {
                   if(state is LoginSuccessState){
                     toast(msg: state.message);
                     navigateTo(context, page: Wrapper());
                   }else if(state is LoginFailureState){
                     toast(msg: state.message);
                   }
                  },
                  child: ElevatedButton(
                      onPressed: () {
                        if (bloc.formKey.currentState!.validate()) {
                          bloc.add(LoginNowEvent(
                              email: bloc.email.text,
                              password: bloc.password.text));
                        }
                      },
                      child: const Text('Login')),
                ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, page:  SignUpScreen());
                  },
                  child: RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: 'Don\'t have Account',
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                    TextSpan(
                        text: ' Sign up',
                        style: TextStyle(color: Colors.blue, fontSize: 16)),
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
