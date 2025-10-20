import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/domain/repositories/pet_repository.dart';
import 'package:pets_app/presentation/blocs/home/home_cubit.dart';
import 'package:pets_app/presentation/blocs/home/home_state.dart';

class MockPetRepository extends Mock implements PetRepository {}

void main() {
  group('HomeCubit', () {
    late MockPetRepository mockPetRepository;
    late HomeCubit homeCubit;

    setUp(() {
      mockPetRepository = MockPetRepository();
      homeCubit = HomeCubit(petRepository: mockPetRepository);
    });

    tearDown(() => homeCubit.close());

    const testPet1 = Pet(
      id: '1',
      name: 'Buddy',
      breed: 'Golden Retriever',
      species: 'Dog',
      gender: 'Male',
      age: 3,
      weight: 30.5,
      imageUrl: 'https://example.com/buddy.jpg',
    );

    const testPet2 = Pet(
      id: '2',
      name: 'Max',
      breed: 'Labrador',
      species: 'Dog',
      gender: 'Female',
      age: 5,
      weight: 28.0,
      imageUrl: 'https://example.com/max.jpg',
    );

    group('getPets', () {
      blocTest<HomeCubit, HomeState>(
        'emits [loading, success] when pets are fetched successfully',
        build: () {
          when(
            () => mockPetRepository.getPets(),
          ).thenAnswer((_) async => [testPet1, testPet2]);
          return homeCubit;
        },
        act: (cubit) => cubit.getPets(),
        expect: () => [
          const HomeState(pets: [], isLoading: true),
          const HomeState(pets: [testPet1, testPet2], isLoading: false),
        ],
        verify: (_) {
          verify(() => mockPetRepository.getPets()).called(1);
        },
      );

      blocTest<HomeCubit, HomeState>(
        'emits [loading, success] when no pets exist',
        build: () {
          when(() => mockPetRepository.getPets()).thenAnswer((_) async => []);
          return homeCubit;
        },
        act: (cubit) => cubit.getPets(),
        expect: () => [
          const HomeState(pets: [], isLoading: true),
          const HomeState(pets: [], isLoading: false),
        ],
        verify: (_) {
          verify(() => mockPetRepository.getPets()).called(1);
        },
      );

      blocTest<HomeCubit, HomeState>(
        'initial state is HomeState with empty pets list',
        build: () => homeCubit,
        expect: () => [],
        verify: (cubit) {
          expect(cubit.state.pets, isEmpty);
          expect(cubit.state.errorMessage, isNull);
          expect(cubit.state.isLoading, isFalse);
        },
      );
    });
  });
}
