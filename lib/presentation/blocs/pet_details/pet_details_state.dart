import 'package:equatable/equatable.dart';
import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/domain/entities/event.dart';

class PetDetailsState extends Equatable {
  final Pet pet;
  final String? errorMessage;
  final List<Event>? events;
  final bool isLoading;
  final bool isPetDeleted;
  final bool isPetEdited;
  final bool isEventAdded;
  final bool isEventUpdated;
  final bool isEventDeleted;

  const PetDetailsState({
    required this.pet,
    this.errorMessage,
    this.events,
    this.isLoading = false,
    this.isPetDeleted = false,
    this.isPetEdited = false,
    this.isEventAdded = false,
    this.isEventUpdated = false,
    this.isEventDeleted = false,
  });

  copyWith({
    Pet? pet,
    String? errorMessage,
    List<Event>? events,
    bool? isLoading,
    bool? isPetDeleted,
    bool? isPetEdited,
    bool? isEventAdded,
    bool? isEventUpdated,
    bool? isEventDeleted,
  }) => PetDetailsState(
    pet: pet ?? this.pet,
    errorMessage: errorMessage ?? this.errorMessage,
    events: events ?? this.events,
    isLoading: isLoading ?? this.isLoading,
    isPetDeleted: isPetDeleted ?? this.isPetDeleted,
    isPetEdited: isPetEdited ?? this.isPetEdited,
    isEventAdded: isEventAdded ?? this.isEventAdded,
    isEventUpdated: isEventUpdated ?? this.isEventUpdated,
    isEventDeleted: isEventDeleted ?? this.isEventDeleted,
  );

  @override
  List<Object?> get props => [
    pet,
    errorMessage,
    events,
    isLoading,
    isPetDeleted,
    isPetEdited,
    isEventAdded,
    isEventUpdated,
    isEventDeleted,
  ];
}
