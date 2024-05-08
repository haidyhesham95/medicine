part of 'request_bloc.dart';

sealed class RequestState {}

final class RequestInitial extends RequestState {}
final class GetAllRequestsLoadingState extends RequestState {}
final class GetAllRequestsSuccessState extends RequestState {
  final List<RequestModel> requests;
  GetAllRequestsSuccessState({required this.requests});
}
final class GetAllRequestsFailureState extends RequestState {
  final String message;
  GetAllRequestsFailureState({required this.message});
}
final class RequestMedicineLoadingState extends RequestState {}
final class RequestMedicineSuccessState extends RequestState {
  final String message;
  RequestMedicineSuccessState({required this.message});
}
final class RequestMedicineFailureState extends RequestState {
  final String message;
  RequestMedicineFailureState({required this.message});
}