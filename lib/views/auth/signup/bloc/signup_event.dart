part of 'signup_bloc.dart';

abstract class SignupEvent  extends Equatable {}
class SignupNowEvent extends SignupEvent{
  final String name,email,password,phone;
  SignupNowEvent({required this.name, required this.email, required this.password, required this.phone});
  @override
  List<Object?> get props => [name,email,password,phone];
}
