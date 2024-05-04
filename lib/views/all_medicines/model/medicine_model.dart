import 'package:equatable/equatable.dart';

class MedicineModel extends Equatable {
  final String name, description, price, image;

  const MedicineModel(
      {required this.name,
      required this.description,
      required this.price,
      required this.image});

  factory MedicineModel.fromJson(json) => MedicineModel(
        name: json['name'],
        description: json['description'],
        price: json['price'],
        image: json['image'],
      );

  @override
  List<Object?> get props => [name, description, price, image];
}
