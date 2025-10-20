import 'package:equatable/equatable.dart';
import 'package:pets_app/domain/entities/pet.dart';

class AddPetState extends Equatable {
  final Pet? pet;
  final String? errorMessage;
  final bool isLoading;

  const AddPetState({this.pet, this.errorMessage, this.isLoading = false});

  copyWith({Pet? pet, String? errorMessage, bool? isLoading}) => AddPetState(
    pet: pet ?? this.pet,
    errorMessage: errorMessage ?? this.errorMessage,
    isLoading: isLoading ?? this.isLoading,
  );

  @override
  List<Object?> get props => [pet, errorMessage, isLoading];
}
