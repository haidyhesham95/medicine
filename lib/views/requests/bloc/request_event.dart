part of 'request_bloc.dart';

abstract class RequestEvent extends Equatable{}

class GetAllRequestsEvent extends RequestEvent{
  @override
  List<Object?> get props => [];
}

class RequestMedicineEvent extends RequestEvent{
  final String medicineId,userId;
  RequestMedicineEvent({required this.medicineId, required this.userId});
  @override
  List<Object?> get props => [medicineId,userId];
}