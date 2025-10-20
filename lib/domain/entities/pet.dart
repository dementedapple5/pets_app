import 'package:equatable/equatable.dart';

class Pet extends Equatable {
  final String id;
  final String name;
  final String breed;
  final String species;
  final String gender;
  final int age;
  final double weight;
  final String imageUrl;

  const Pet({
    required this.id,
    required this.name,
    required this.breed,
    required this.species,
    required this.gender,
    required this.age,
    required this.weight,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, breed, gender, age, weight, imageUrl];
}
