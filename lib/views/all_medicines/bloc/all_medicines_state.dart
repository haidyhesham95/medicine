part of 'all_medicines_bloc.dart';

sealed class AllMedicinesState {}

final class AllMedicinesInitial extends AllMedicinesState {}
final class GetAllMedicinesLoadingState extends AllMedicinesState {}
final class GetAllMedicinesSuccessState extends AllMedicinesState {
  final List<MedicineModel> medicines;
  GetAllMedicinesSuccessState({required this.medicines});
}
final class GetAllMedicinesFailureState extends AllMedicinesState {
  final String message;
  GetAllMedicinesFailureState({required this.message});
}
