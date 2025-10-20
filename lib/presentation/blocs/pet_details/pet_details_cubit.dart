import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_app/domain/entities/event.dart';
import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/domain/repositories/event_repository.dart';
import 'package:pets_app/domain/repositories/pet_repository.dart';
import 'package:pets_app/presentation/blocs/pet_details/pet_details_state.dart';
import 'package:pets_app/presentation/ui/utils/image_storage_service.dart';

class PetDetailsCubit extends Cubit<PetDetailsState> {
  final PetRepository _petRepository;
  final EventRepository _eventRepository;
  final Pet _pet;
  PetDetailsCubit({
    required PetRepository petRepository,
    required EventRepository eventRepository,
    required Pet pet,
  }) : _petRepository = petRepository,
       _eventRepository = eventRepository,
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
    emit(state.copyWith(isLoading: false, isEventAdded: true));
    emit(state.copyWith(isEventAdded: false));
  }

  Future<void> updateEvent(Event event) async {
    emit(state.copyWith(isLoading: true));
    await _eventRepository.updateEvent(event);
    emit(state.copyWith(isLoading: false, isEventUpdated: true));
  }

  Future<void> deleteEvent(String id) async {
    emit(state.copyWith(isLoading: true));
    await _eventRepository.deleteEvent(id);
    emit(state.copyWith(isLoading: false, isEventDeleted: true));
  }
}
