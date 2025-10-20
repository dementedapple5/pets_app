import 'package:pets_app/domain/entities/pet.dart';

abstract class PetRepository {
  Future<List<Pet>> getPets();
  Future<bool> addPet(Pet pet);
  Future<bool> updatePet(Pet pet);
  Future<bool> deletePet(String id);
}
