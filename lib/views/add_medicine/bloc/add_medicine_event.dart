part of 'add_medicine_bloc.dart';

sealed class AddMedicineEvent extends Equatable{}
class AddMedicineNowEvent extends AddMedicineEvent{
  final String name,price,description,imageName;
  final File image;
  AddMedicineNowEvent({required this.name, required this.price, required this.description, required this.image,required this.imageName});
  @override
  List<Object?> get props => [name,price,description,image,imageName];
}