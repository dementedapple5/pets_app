import 'package:pets_app/data/local/models/pet_model.dart';
import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/domain/repositories/pet_repository.dart';
import 'package:pets_app/data/local/db/pet_local_data_source.dart';

class PetRepositoryImpl implements PetRepository {
  final PetLocalDataSource _petDataSource;

  PetRepositoryImpl({required PetLocalDataSource petDataSource})
    : _petDataSource = petDataSource;

  @override
  Future<List<Pet>> getPets() =>
      _petDataSource.getPets().then((value) => value.pets);

  @override
  Future<bool> addPet(Pet pet) =>
      _petDataSource.addPet(PetModel.fromEntity(pet)).then((value) => value);

  @override
  Future<bool> deletePet(String id) =>
      _petDataSource.deletePet(id).then((value) => value);

  @override
  Future<bool> updatePet(Pet pet) =>
      _petDataSource.updatePet(PetModel.fromEntity(pet)).then((value) => value);
}
