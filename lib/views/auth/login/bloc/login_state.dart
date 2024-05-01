part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoadingState extends LoginState {}
class LoginSuccessState extends LoginState {
  final String message;
  LoginSuccessState({required this.message});
}
class LoginFailureState extends LoginState {
  final String message;
  LoginFailureState({required this.message});
}
