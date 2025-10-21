import 'package:pets_app/domain/entities/event.dart';

class EventModel extends Event {
  const EventModel({
    required super.id,
    required super.name,
    required super.petId,
    required super.description,
    required super.date,
    required super.location,
    super.notificationEnabled,
  });

  factory EventModel.fromEntity(Event event) => EventModel(
    id: event.id,
    name: event.name,
    petId: event.petId,
    description: event.description,
    date: event.date,
    location: event.location,
    notificationEnabled: event.notificationEnabled,
  );

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    id: json['id'],
    name: json['name'],
    petId: json['petId'],
    description: json['description'],
    date: DateTime.parse(json['date'] as String),
    location: json['location'],
    notificationEnabled: json['notificationEnabled'] == 1,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'petId': petId,
    'description': description,
    'date': date.toIso8601String(),
    'location': location,
    'notificationEnabled': notificationEnabled ? 1 : 0,
  };
}
