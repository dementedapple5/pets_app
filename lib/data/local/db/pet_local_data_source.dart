import 'package:pets_app/data/local/db/database_helper.dart';
import 'package:pets_app/data/local/models/get_pets_response_model.dart';
import 'package:pets_app/data/local/models/pet_model.dart';

abstract class PetLocalDataSource {
  Future<GetPetsResponseModel> getPets();
  Future<bool> addPet(PetModel pet);
  Future<bool> updatePet(PetModel pet);
  Future<bool> deletePet(String id);
}

class PetLocalDataSourceImpl implements PetLocalDataSource {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Future<GetPetsResponseModel> getPets() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> petsMaps = await db.query(
      'pets',
      orderBy: 'name ASC',
    );
    return GetPetsResponseModel(
      pets: petsMaps.map((map) => PetModel.fromJson(map)).toList(),
      errorMessage: '',
    );
  }

  @override
  Future<bool> addPet(PetModel pet) async {
    final db = await _databaseHelper.database;
    final result = await db.insert('pets', pet.toJson());
    if (result == 0) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> updatePet(PetModel pet) async {
    final db = await _databaseHelper.database;
    final result = await db.update(
      'pets',
      pet.toJson(),
      where: 'id = ?',
      whereArgs: [pet.id],
    );
    if (result == 0) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> deletePet(String id) async {
    final db = await _databaseHelper.database;
    final result = await db.delete('pets', where: 'id = ?', whereArgs: [id]);
    if (result == 0) {
      return false;
    }
    return true;
  }
}
