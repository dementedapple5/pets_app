import 'package:equatable/equatable.dart';
import 'package:pets_app/domain/entities/pet.dart';

class HomeState extends Equatable {
  final List<Pet> pets;
  final String? errorMessage;
  final bool isLoading;

  const HomeState({
    required this.pets,
    this.errorMessage,
    this.isLoading = false,
  });

  copyWith({List<Pet>? pets, String? errorMessage, bool? isLoading}) =>
      HomeState(
        pets: pets ?? this.pets,
        errorMessage: errorMessage ?? this.errorMessage,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [pets, errorMessage, isLoading];
}
