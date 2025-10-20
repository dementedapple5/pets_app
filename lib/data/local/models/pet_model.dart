import 'package:pets_app/domain/entities/pet.dart';

class PetModel extends Pet {
  const PetModel({
    required super.id,
    required super.name,
    required super.breed,
    required super.species,
    required super.gender,
    required super.age,
    required super.weight,
    required super.imageUrl,
  });

  factory PetModel.fromEntity(Pet pet) => PetModel(
    id: pet.id,
    name: pet.name,
    breed: pet.breed,
    species: pet.species,
    gender: pet.gender,
    age: pet.age,
    weight: pet.weight,
    imageUrl: pet.imageUrl,
  );

  factory PetModel.fromJson(Map<String, dynamic> json) => PetModel(
    id: json['id'],
    name: json['name'],
    breed: json['breed'],
    species: json['species'],
    gender: json['gender'],
    age: json['age'],
    weight: json['weight'],
    imageUrl: json['imageUrl'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'breed': breed,
    'species': species,
    'gender': gender,
    'age': age,
    'weight': weight,
    'imageUrl': imageUrl,
  };
}
