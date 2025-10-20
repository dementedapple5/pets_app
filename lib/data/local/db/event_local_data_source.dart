import 'package:pets_app/data/local/db/database_helper.dart';
import 'package:pets_app/data/local/models/event_model.dart';
import 'package:pets_app/data/local/models/get_events_response_model.dart';

abstract class EventLocalDataSource {
  Future<void> addEvent(EventModel event);
  Future<void> updateEvent(EventModel event);
  Future<void> deleteEvent(String id);
  Future<GetEventsResponseModel> getEventsByPetId(String petId);
}

class EventLocalDataSourceImpl implements EventLocalDataSource {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Future<void> addEvent(EventModel event) async {
    final db = await _databaseHelper.database;
    await db.insert('events', event.toJson());
  }

  @override
  Future<void> updateEvent(EventModel event) async {
    final db = await _databaseHelper.database;
    await db.update(
      'events',
      event.toJson(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  @override
  Future<void> deleteEvent(String id) async {
    final db = await _databaseHelper.database;
    await db.delete('events', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<GetEventsResponseModel> getEventsByPetId(String petId) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> eventsMaps = await db.query(
      'events',
      where: 'petId = ?',
      whereArgs: [petId],
      orderBy: 'date ASC',
    );
    return GetEventsResponseModel(
      events: eventsMaps.map((map) => EventModel.fromJson(map)).toList(),
      errorMessage: '',
    );
  }
}
