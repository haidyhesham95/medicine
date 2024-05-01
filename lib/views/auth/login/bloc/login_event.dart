part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {}
class LoginNowEvent extends LoginEvent{
  final String email,password;
  LoginNowEvent({required this.email, required this.password});
  @override
  List<Object?> get props => [email,password];
}
