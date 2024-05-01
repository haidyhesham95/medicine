part of 'signup_bloc.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}
class SignupLoadingState extends SignupState {}
class SignupSuccessState extends SignupState {
  final String message;
  SignupSuccessState({required this.message});
}
class SignupFailureState extends SignupState {
  final String message;
  SignupFailureState({required this.message});
}