part of 'all_medicines_bloc.dart';

abstract class AllMedicinesEvent extends Equatable{}
// class GetAllMedicinesEvent extends AllMedicinesEvent{
//   @override
//   List<Object?> get props => [];
// }
class GetAllMedicinesEvent extends AllMedicinesEvent {
  final BuildContext context;

  GetAllMedicinesEvent(this.context);

  @override
  List<Object?> get props => [];
}
// class RequestMedicineEvent extends AllMedicinesEvent{
//   final String medicineId,userId;
//   RequestMedicineEvent({required this.medicineId, required this.userId});
//   @override
//   List<Object?> get props => [medicineId,userId];
// }
