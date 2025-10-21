import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pets_app/domain/entities/event.dart';
import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/domain/repositories/event_repository.dart';
import 'package:pets_app/domain/repositories/pet_repository.dart';
import 'package:pets_app/presentation/blocs/pet_details/pet_details_cubit.dart';
import 'package:pets_app/presentation/blocs/pet_details/pet_details_state.dart';
import 'package:pets_app/presentation/ui/utils/notification_service.dart';

class MockPetRepository extends Mock implements PetRepository {}

class MockEventRepository extends Mock implements EventRepository {}

class MockNotificationService extends Mock implements NotificationService {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      Event(
        id: '',
        name: '',
        petId: '',
        description: '',
        date: DateTime(2024, 1, 1),
        location: '',
      ),
    );
  });

  group('PetDetailsCubit', () {
    late MockPetRepository mockPetRepository;
    late MockEventRepository mockEventRepository;
    late MockNotificationService mockNotificationService;
    late PetDetailsCubit petDetailsCubit;

    setUp(() {
      mockPetRepository = MockPetRepository();
      mockEventRepository = MockEventRepository();
      mockNotificationService = MockNotificationService();

      // Setup default stubs for notification service
      when(
        () => mockNotificationService.scheduleEventNotification(any()),
      ).thenAnswer((_) async {});
      when(
        () => mockNotificationService.cancelEventNotification(any()),
      ).thenAnswer((_) async {});
    });

    tearDown(() => petDetailsCubit.close());

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

    const updatedPet = Pet(
      id: '1',
      name: 'Buddy Updated',
      breed: 'Golden Retriever',
      species: 'Dog',
      gender: 'Male',
      age: 4,
      weight: 31.0,
      imageUrl: 'https://example.com/buddy.jpg',
    );

    final testDate = DateTime(2024, 10, 19, 10, 30);

    final testEvent = Event(
      id: '1',
      name: 'Vaccination',
      petId: 'pet1',
      description: 'Annual vaccination',
      date: testDate,
      location: 'Veterinary Clinic',
    );

    group('editPet', () {
      setUp(() {
        petDetailsCubit = PetDetailsCubit(
          petRepository: mockPetRepository,
          eventRepository: mockEventRepository,
          notificationService: mockNotificationService,
          pet: testPet,
        );
      });

      blocTest<PetDetailsCubit, PetDetailsState>(
        'emits [loading, success, reset] when pet is edited successfully',
        build: () {
          when(
            () => mockPetRepository.updatePet(updatedPet),
          ).thenAnswer((_) async => true);
          return petDetailsCubit;
        },
        act: (cubit) => cubit.editPet(updatedPet),
        expect: () => [
          PetDetailsState(pet: testPet, isLoading: true),
          PetDetailsState(pet: updatedPet, isLoading: false, isPetEdited: true),
          PetDetailsState(
            pet: updatedPet,
            isLoading: false,
            isPetEdited: false,
          ),
        ],
        verify: (_) {
          verify(() => mockPetRepository.updatePet(updatedPet)).called(1);
        },
      );
    });

    group('deletePet', () {
      setUp(() {
        petDetailsCubit = PetDetailsCubit(
          petRepository: mockPetRepository,
          eventRepository: mockEventRepository,
          notificationService: mockNotificationService,
          pet: testPet,
        );
      });

      blocTest<PetDetailsCubit, PetDetailsState>(
        'emits [loading, success] when pet is deleted successfully',
        build: () {
          when(
            () => mockPetRepository.deletePet('1'),
          ).thenAnswer((_) async => true);
          return petDetailsCubit;
        },
        act: (cubit) => cubit.deletePet(),
        expect: () => [
          PetDetailsState(pet: testPet, isLoading: true),
          PetDetailsState(pet: testPet, isLoading: false, isPetDeleted: true),
        ],
        verify: (_) {
          verify(() => mockPetRepository.deletePet('1')).called(1);
        },
      );
    });

    group('getPetEvents', () {
      setUp(() {
        petDetailsCubit = PetDetailsCubit(
          petRepository: mockPetRepository,
          eventRepository: mockEventRepository,
          notificationService: mockNotificationService,
          pet: testPet,
        );
      });

      blocTest<PetDetailsCubit, PetDetailsState>(
        'emits [loading, success] when events are fetched',
        build: () {
          when(
            () => mockEventRepository.getEventsByPetId('1'),
          ).thenAnswer((_) async => [testEvent]);
          return petDetailsCubit;
        },
        act: (cubit) => cubit.getPetEvents(),
        expect: () => [
          PetDetailsState(pet: testPet, isLoading: true),
          PetDetailsState(pet: testPet, events: [testEvent], isLoading: false),
        ],
        verify: (_) {
          verify(() => mockEventRepository.getEventsByPetId('1')).called(1);
        },
      );

      blocTest<PetDetailsCubit, PetDetailsState>(
        'emits [loading, success] when no events exist',
        build: () {
          when(
            () => mockEventRepository.getEventsByPetId('1'),
          ).thenAnswer((_) async => []);
          return petDetailsCubit;
        },
        act: (cubit) => cubit.getPetEvents(),
        expect: () => [
          PetDetailsState(pet: testPet, isLoading: true),
          PetDetailsState(pet: testPet, events: [], isLoading: false),
        ],
        verify: (_) {
          verify(() => mockEventRepository.getEventsByPetId('1')).called(1);
        },
      );
    });

    group('addEvent', () {
      setUp(() {
        petDetailsCubit = PetDetailsCubit(
          petRepository: mockPetRepository,
          eventRepository: mockEventRepository,
          notificationService: mockNotificationService,
          pet: testPet,
        );
      });

      blocTest<PetDetailsCubit, PetDetailsState>(
        'emits [loading, success, reset] when event is added',
        build: () {
          when(
            () => mockEventRepository.addEvent(testEvent),
          ).thenAnswer((_) async {});
          return petDetailsCubit;
        },
        act: (cubit) => cubit.addEvent(testEvent),
        expect: () => [
          PetDetailsState(pet: testPet, isLoading: true),
          PetDetailsState(pet: testPet, isLoading: false, isEventAdded: true),
          PetDetailsState(pet: testPet, isLoading: false, isEventAdded: false),
        ],
        verify: (_) {
          verify(() => mockEventRepository.addEvent(testEvent)).called(1);
        },
      );
    });

    group('updateEvent', () {
      setUp(() {
        petDetailsCubit = PetDetailsCubit(
          petRepository: mockPetRepository,
          eventRepository: mockEventRepository,
          notificationService: mockNotificationService,
          pet: testPet,
        );
      });

      blocTest<PetDetailsCubit, PetDetailsState>(
        'emits [loading, success] when event is updated',
        build: () {
          when(
            () => mockEventRepository.updateEvent(testEvent),
          ).thenAnswer((_) async {});
          return petDetailsCubit;
        },
        act: (cubit) => cubit.updateEvent(testEvent),
        expect: () => [
          PetDetailsState(pet: testPet, isLoading: true),
          PetDetailsState(pet: testPet, isLoading: false, isEventUpdated: true),
        ],
        verify: (_) {
          verify(() => mockEventRepository.updateEvent(testEvent)).called(1);
        },
      );
    });

    group('deleteEvent', () {
      setUp(() {
        petDetailsCubit = PetDetailsCubit(
          petRepository: mockPetRepository,
          eventRepository: mockEventRepository,
          notificationService: mockNotificationService,
          pet: testPet,
        );
      });

      blocTest<PetDetailsCubit, PetDetailsState>(
        'emits [loading, success] when event is deleted',
        build: () {
          when(
            () => mockEventRepository.deleteEvent('1'),
          ).thenAnswer((_) async {});
          return petDetailsCubit;
        },
        act: (cubit) => cubit.deleteEvent('1'),
        expect: () => [
          PetDetailsState(pet: testPet, isLoading: true),
          PetDetailsState(pet: testPet, isLoading: false, isEventDeleted: true),
        ],
        verify: (_) {
          verify(() => mockEventRepository.deleteEvent('1')).called(1);
        },
      );
    });
  });
}
