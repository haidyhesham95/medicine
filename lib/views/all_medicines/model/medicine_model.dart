import 'package:equatable/equatable.dart';

class MedicineModel extends Equatable {
  final String name, description, price, image, id;

  const MedicineModel({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.id,
  });

  factory MedicineModel.fromJson(json, id) => MedicineModel(
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      id: id);

  @override
  List<Object?> get props => [name, description, price, image];
}
