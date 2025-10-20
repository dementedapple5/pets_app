import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/domain/repositories/pet_repository.dart';
import 'package:pets_app/presentation/blocs/add_pet/add_pet_cubit.dart';
import 'package:pets_app/presentation/blocs/add_pet/add_pet_state.dart';

class MockPetRepository extends Mock implements PetRepository {}

void main() {
  group('AddPetCubit', () {
    late MockPetRepository mockPetRepository;
    late AddPetCubit addPetCubit;

    setUp(() {
      mockPetRepository = MockPetRepository();
      addPetCubit = AddPetCubit(petRepository: mockPetRepository);
    });

    tearDown(() => addPetCubit.close());

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

    group('addPet', () {
      blocTest<AddPetCubit, AddPetState>(
        'emits [loading, success] when pet is added successfully',
        build: () {
          when(
            () => mockPetRepository.addPet(testPet),
          ).thenAnswer((_) async => true);
          return addPetCubit;
        },
        act: (cubit) => cubit.addPet(testPet),
        expect: () => [
          const AddPetState(isLoading: true),
          const AddPetState(pet: testPet, isLoading: false),
        ],
        verify: (_) {
          verify(() => mockPetRepository.addPet(testPet)).called(1);
        },
      );

      blocTest<AddPetCubit, AddPetState>(
        'emits [loading, error] when pet addition fails',
        build: () {
          when(
            () => mockPetRepository.addPet(testPet),
          ).thenAnswer((_) async => false);
          return addPetCubit;
        },
        act: (cubit) => cubit.addPet(testPet),
        expect: () => [
          const AddPetState(isLoading: true),
          const AddPetState(
            errorMessage: 'Failed to add pet',
            isLoading: false,
          ),
        ],
        verify: (_) {
          verify(() => mockPetRepository.addPet(testPet)).called(1);
        },
      );

      blocTest<AddPetCubit, AddPetState>(
        'initial state is AddPetState with default values',
        build: () => addPetCubit,
        expect: () => [],
        verify: (cubit) {
          expect(cubit.state.pet, isNull);
          expect(cubit.state.errorMessage, isNull);
          expect(cubit.state.isLoading, isFalse);
        },
      );
    });
  });
}
