import 'package:pets_app/domain/entities/event.dart';

abstract class EventRepository {
  Future<List<Event>> getEventsByPetId(String petId);
  Future<void> addEvent(Event event);
  Future<void> updateEvent(Event event);
  Future<void> deleteEvent(String id);
}
