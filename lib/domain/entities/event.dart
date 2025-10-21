import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String id;
  final String petId;
  final String name;
  final String description;
  final DateTime date;
  final String location;
  final bool notificationEnabled;

  const Event({
    required this.id,
    required this.name,
    required this.petId,
    required this.description,
    required this.date,
    required this.location,
    this.notificationEnabled = true,
  });

  Event copyWith({
    String? id,
    String? petId,
    String? name,
    String? description,
    DateTime? date,
    String? location,
    bool? notificationEnabled,
  }) {
    return Event(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      name: name ?? this.name,
      description: description ?? this.description,
      date: date ?? this.date,
      location: location ?? this.location,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    petId,
    description,
    date,
    location,
    notificationEnabled,
  ];
}
