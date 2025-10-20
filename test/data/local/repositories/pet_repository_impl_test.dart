import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pets_app/data/local/db/pet_local_data_source.dart';
import 'package:pets_app/data/local/models/get_pets_response_model.dart';
import 'package:pets_app/data/local/models/pet_model.dart';
import 'package:pets_app/data/local/repositories/pet_repository_impl.dart';
import 'package:pets_app/domain/entities/pet.dart';

class MockPetLocalDataSource extends Mock implements PetLocalDataSource {}

void main() {
  group('PetRepositoryImpl', () {
    late MockPetLocalDataSource mockPetLocalDataSource;
    late PetRepositoryImpl petRepositoryImpl;

    setUpAll(() {
      registerFallbackValue(
        const PetModel(
          id: '',
          name: '',
          breed: '',
          species: '',
          gender: '',
          age: 0,
          weight: 0.0,
          imageUrl: '',
        ),
      );
    });

    setUp(() {
      mockPetLocalDataSource = MockPetLocalDataSource();
      petRepositoryImpl = PetRepositoryImpl(
        petDataSource: mockPetLocalDataSource,
      );
    });

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

    const testPet = Pet(
      id: '1',
      name: 'Buddy',
      breed: 'Golden Retriever',
      species: 'Dog',
      gender: 'Male',
      age: 3,
      weight: 30.5,
      imageUrl: 'https://example.com/buddy.jpg',
    );

    group('getPets', () {
      test('returns list of pets when data source call succeeds', () async {
        final testResponse = GetPetsResponseModel(
          pets: [testPetModel],
          errorMessage: '',
        );

        when(
          () => mockPetLocalDataSource.getPets(),
        ).thenAnswer((_) async => testResponse);

        final result = await petRepositoryImpl.getPets();

        expect(result, equals([testPetModel]));
        verify(() => mockPetLocalDataSource.getPets()).called(1);
      });

      test('returns empty list when no pets exist', () async {
        final testResponse = GetPetsResponseModel(pets: [], errorMessage: '');

        when(
          () => mockPetLocalDataSource.getPets(),
        ).thenAnswer((_) async => testResponse);

        final result = await petRepositoryImpl.getPets();

        expect(result, isEmpty);
        verify(() => mockPetLocalDataSource.getPets()).called(1);
      });

      test('throws exception when data source fails', () async {
        when(
          () => mockPetLocalDataSource.getPets(),
        ).thenThrow(Exception('Database error'));

        expect(() => petRepositoryImpl.getPets(), throwsException);
        verify(() => mockPetLocalDataSource.getPets()).called(1);
      });
    });

    group('addPet', () {
      test('returns true when pet is added successfully', () async {
        when(
          () => mockPetLocalDataSource.addPet(any()),
        ).thenAnswer((_) async => true);

        final result = await petRepositoryImpl.addPet(testPet);

        expect(result, isTrue);
        verify(() => mockPetLocalDataSource.addPet(any())).called(1);
      });

      test('returns false when pet addition fails', () async {
        when(
          () => mockPetLocalDataSource.addPet(any()),
        ).thenAnswer((_) async => false);

        final result = await petRepositoryImpl.addPet(testPet);

        expect(result, isFalse);
        verify(() => mockPetLocalDataSource.addPet(any())).called(1);
      });

      test('converts Pet entity to PetModel before saving', () async {
        when(
          () => mockPetLocalDataSource.addPet(any()),
        ).thenAnswer((_) async => true);

        await petRepositoryImpl.addPet(testPet);

        verify(
          () => mockPetLocalDataSource.addPet(
            any(that: isA<PetModel>().having((m) => m.id, 'id', testPet.id)),
          ),
        ).called(1);
      });

      test('throws exception when data source fails', () async {
        when(
          () => mockPetLocalDataSource.addPet(any()),
        ).thenThrow(Exception('Database error'));

        expect(() => petRepositoryImpl.addPet(testPet), throwsException);
      });
    });

    group('deletePet', () {
      test('returns true when pet is deleted successfully', () async {
        when(
          () => mockPetLocalDataSource.deletePet('1'),
        ).thenAnswer((_) async => true);

        final result = await petRepositoryImpl.deletePet('1');

        expect(result, isTrue);
        verify(() => mockPetLocalDataSource.deletePet('1')).called(1);
      });

      test('returns false when pet deletion fails', () async {
        when(
          () => mockPetLocalDataSource.deletePet('1'),
        ).thenAnswer((_) async => false);

        final result = await petRepositoryImpl.deletePet('1');

        expect(result, isFalse);
        verify(() => mockPetLocalDataSource.deletePet('1')).called(1);
      });

      test('throws exception when data source fails', () async {
        when(
          () => mockPetLocalDataSource.deletePet('1'),
        ).thenThrow(Exception('Database error'));

        expect(() => petRepositoryImpl.deletePet('1'), throwsException);
      });
    });

    group('updatePet', () {
      test('returns true when pet is updated successfully', () async {
        when(
          () => mockPetLocalDataSource.updatePet(any()),
        ).thenAnswer((_) async => true);

        final result = await petRepositoryImpl.updatePet(testPet);

        expect(result, isTrue);
        verify(() => mockPetLocalDataSource.updatePet(any())).called(1);
      });

      test('returns false when pet update fails', () async {
        when(
          () => mockPetLocalDataSource.updatePet(any()),
        ).thenAnswer((_) async => false);

        final result = await petRepositoryImpl.updatePet(testPet);

        expect(result, isFalse);
        verify(() => mockPetLocalDataSource.updatePet(any())).called(1);
      });

      test('converts Pet entity to PetModel before updating', () async {
        when(
          () => mockPetLocalDataSource.updatePet(any()),
        ).thenAnswer((_) async => true);

        await petRepositoryImpl.updatePet(testPet);

        verify(
          () => mockPetLocalDataSource.updatePet(
            any(that: isA<PetModel>().having((m) => m.id, 'id', testPet.id)),
          ),
        ).called(1);
      });

      test('throws exception when data source fails', () async {
        when(
          () => mockPetLocalDataSource.updatePet(any()),
        ).thenThrow(Exception('Database error'));

        expect(() => petRepositoryImpl.updatePet(testPet), throwsException);
      });
    });
  });
}
