import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String id;
  final String petId;
  final String name;
  final String description;
  final DateTime date;
  final String location;

  const Event({
    required this.id,
    required this.name,
    required this.petId,
    required this.description,
    required this.date,
    required this.location,
  });

  @override
  List<Object?> get props => [id, name, petId, description, date, location];
}
