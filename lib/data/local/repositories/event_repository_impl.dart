import 'package:pets_app/data/local/db/event_local_data_source.dart';
import 'package:pets_app/data/local/models/event_model.dart';
import 'package:pets_app/domain/entities/event.dart';
import 'package:pets_app/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventLocalDataSource _eventLocalDataSource;
  EventRepositoryImpl({required EventLocalDataSource eventLocalDataSource})
    : _eventLocalDataSource = eventLocalDataSource;

  @override
  Future<List<Event>> getEventsByPetId(String petId) => _eventLocalDataSource
      .getEventsByPetId(petId)
      .then((value) => value.events);

  @override
  Future<void> addEvent(Event event) =>
      _eventLocalDataSource.addEvent(EventModel.fromEntity(event));

  @override
  Future<void> deleteEvent(String id) => _eventLocalDataSource.deleteEvent(id);

  @override
  Future<void> updateEvent(Event event) =>
      _eventLocalDataSource.updateEvent(EventModel.fromEntity(event));
}
