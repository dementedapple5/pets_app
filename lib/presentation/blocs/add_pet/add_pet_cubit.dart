import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/domain/repositories/pet_repository.dart';
import 'package:pets_app/presentation/blocs/add_pet/add_pet_state.dart';

class AddPetCubit extends Cubit<AddPetState> {
  final PetRepository _petRepository;
  AddPetCubit({required PetRepository petRepository})
    : _petRepository = petRepository,
      super(const AddPetState());

  Future<void> addPet(Pet pet) async {
    emit(state.copyWith(isLoading: true));
    final petResponse = await _petRepository.addPet(pet);
    if (petResponse) {
      emit(state.copyWith(pet: pet, isLoading: false));
    } else {
      emit(state.copyWith(errorMessage: 'Failed to add pet', isLoading: false));
    }
  }
}
