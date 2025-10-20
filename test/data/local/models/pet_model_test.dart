import 'package:flutter_test/flutter_test.dart';
import 'package:pets_app/data/local/models/pet_model.dart';
import 'package:pets_app/domain/entities/pet.dart';

void main() {
  group('PetModel', () {
    const testPetModel = PetModel(
      id: '1',
      name: 'Buddy',
      breed: 'Golden Retriever',
      species: 'Dog',
      gender: 'Male',
      age: 3,
      weight: 30.5,
      imageUrl: 'https://example.com/buddy.jpg',
    );

    const testPetJson = {
      'id': '1',
      'name': 'Buddy',
      'breed': 'Golden Retriever',
      'species': 'Dog',
      'gender': 'Male',
      'age': 3,
      'weight': 30.5,
      'imageUrl': 'https://example.com/buddy.jpg',
    };

    test('fromJson creates PetModel correctly', () {
      final result = PetModel.fromJson(testPetJson);

      expect(result.id, equals('1'));
      expect(result.name, equals('Buddy'));
      expect(result.breed, equals('Golden Retriever'));
      expect(result.species, equals('Dog'));
      expect(result.gender, equals('Male'));
      expect(result.age, equals(3));
      expect(result.weight, equals(30.5));
      expect(result.imageUrl, equals('https://example.com/buddy.jpg'));
    });

    test('toJson converts PetModel to JSON correctly', () {
      final result = testPetModel.toJson();

      expect(result, equals(testPetJson));
    });

    test('fromEntity creates PetModel from Pet entity', () {
      const pet = Pet(
        id: '2',
        name: 'Max',
        breed: 'Labrador',
        species: 'Dog',
        gender: 'Female',
        age: 5,
        weight: 28.0,
        imageUrl: 'https://example.com/max.jpg',
      );

      final result = PetModel.fromEntity(pet);

      expect(result.id, equals('2'));
      expect(result.name, equals('Max'));
      expect(result.breed, equals('Labrador'));
      expect(result.species, equals('Dog'));
      expect(result.gender, equals('Female'));
      expect(result.age, equals(5));
      expect(result.weight, equals(28.0));
      expect(result.imageUrl, equals('https://example.com/max.jpg'));
    });

    test('PetModel extends Pet correctly', () {
      expect(testPetModel, isA<Pet>());
    });

    test('two PetModels with same data are equal', () {
      const petModel1 = PetModel(
        id: '1',
        name: 'Buddy',
        breed: 'Golden Retriever',
        species: 'Dog',
        gender: 'Male',
        age: 3,
        weight: 30.5,
        imageUrl: 'https://example.com/buddy.jpg',
      );

      const petModel2 = PetModel(
        id: '1',
        name: 'Buddy',
        breed: 'Golden Retriever',
        species: 'Dog',
        gender: 'Male',
        age: 3,
        weight: 30.5,
        imageUrl: 'https://example.com/buddy.jpg',
      );

      expect(petModel1, equals(petModel2));
    });

    test('roundtrip conversion: toJson and fromJson', () {
      final json = testPetModel.toJson();
      final result = PetModel.fromJson(json);

      expect(result, equals(testPetModel));
    });
  });
}
