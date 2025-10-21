import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_app/domain/entities/event.dart';
import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/domain/repositories/event_repository.dart';
import 'package:pets_app/domain/repositories/pet_repository.dart';
import 'package:pets_app/presentation/blocs/pet_details/pet_details_state.dart';
import 'package:pets_app/presentation/ui/utils/image_storage_service.dart';
import 'package:pets_app/presentation/ui/utils/notification_service.dart';

class PetDetailsCubit extends Cubit<PetDetailsState> {
  final PetRepository _petRepository;
  final EventRepository _eventRepository;
  final NotificationService _notificationService;
  final Pet _pet;
  PetDetailsCubit({
    required PetRepository petRepository,
    required EventRepository eventRepository,
    required NotificationService notificationService,
    required Pet pet,
  }) : _petRepository = petRepository,
       _eventRepository = eventRepository,
       _notificationService = notificationService,
       _pet = pet,
       super(PetDetailsState(pet: pet));

  editPet(Pet pet) async {
    emit(state.copyWith(isLoading: true));
    await _petRepository.updatePet(pet);
    emit(state.copyWith(isLoading: false, isPetEdited: true, pet: pet));
    emit(state.copyWith(isPetEdited: false));
  }

  Future<void> deletePet() async {
    emit(state.copyWith(isLoading: true));

    if (ImageStorageService.isLocalImage(state.pet.imageUrl)) {
      await ImageStorageService.deleteImage(state.pet.imageUrl);
    }

    await _petRepository.deletePet(state.pet.id);
    emit(state.copyWith(isLoading: false, isPetDeleted: true));
  }

  Future<void> getPetEvents() async {
    emit(state.copyWith(isLoading: true));
    final events = await _eventRepository.getEventsByPetId(_pet.id);
    emit(state.copyWith(events: events, isLoading: false));
  }

  Future<void> addEvent(Event event) async {
    emit(state.copyWith(isLoading: true));
    await _eventRepository.addEvent(event);

    // Schedule notification if enabled
    if (event.notificationEnabled) {
      await _notificationService.scheduleEventNotification(event);
    }

    emit(state.copyWith(isLoading: false, isEventAdded: true));
    emit(state.copyWith(isEventAdded: false));
  }

  Future<void> updateEvent(Event event) async {
    emit(state.copyWith(isLoading: true));
    await _eventRepository.updateEvent(event);

    // Cancel old notification and schedule new one if enabled
    await _notificationService.cancelEventNotification(event.id);
    if (event.notificationEnabled) {
      await _notificationService.scheduleEventNotification(event);
    }

    emit(
      state.copyWith(
        isLoading: false,
        isEventUpdated: true,
        events: state.events?.map((e) => e.id == event.id ? event : e).toList(),
      ),
    );
    emit(state.copyWith(isEventUpdated: false));
  }

  Future<void> deleteEvent(String id) async {
    emit(state.copyWith(isLoading: true));
    await _eventRepository.deleteEvent(id);

    // Cancel notification for deleted event
    await _notificationService.cancelEventNotification(id);

    emit(
      state.copyWith(
        isLoading: false,
        isEventDeleted: true,
        events: state.events?.where((e) => e.id != id).toList(),
      ),
    );
    emit(state.copyWith(isEventDeleted: false));
  }
}
