import 'package:pets_app/data/local/models/pet_model.dart';

class GetPetsResponseModel {
  final List<PetModel> pets;
  final String errorMessage;

  const GetPetsResponseModel({required this.pets, required this.errorMessage});

  factory GetPetsResponseModel.fromJson(Map<String, dynamic> json) =>
      GetPetsResponseModel(
        pets: json['pets'].map((pet) => PetModel.fromJson(pet)).toList(),
        errorMessage: json['errorMessage'],
      );
}
