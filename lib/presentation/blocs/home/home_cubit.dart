import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_app/domain/repositories/pet_repository.dart';
import 'package:pets_app/presentation/blocs/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PetRepository _petRepository;
  HomeCubit({required PetRepository petRepository})
    : _petRepository = petRepository,
      super(const HomeState(pets: []));

  Future<void> getPets() async {
    emit(state.copyWith(isLoading: true));
    final petsRsponse = await _petRepository.getPets();
    emit(state.copyWith(pets: petsRsponse, isLoading: false));
  }
}
