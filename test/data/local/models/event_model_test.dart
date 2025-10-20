import 'package:flutter_test/flutter_test.dart';
import 'package:pets_app/data/local/models/event_model.dart';
import 'package:pets_app/domain/entities/event.dart';

void main() {
  group('EventModel', () {
    final testDate = DateTime(2024, 10, 19, 10, 30);

    final testEventModel = EventModel(
      id: '1',
      name: 'Vaccination',
      petId: 'pet1',
      description: 'Annual vaccination for Buddy',
      date: testDate,
      location: 'Veterinary Clinic',
    );

    final testEventJson = {
      'id': '1',
      'name': 'Vaccination',
      'petId': 'pet1',
      'description': 'Annual vaccination for Buddy',
      'date': testDate.toIso8601String(),
      'location': 'Veterinary Clinic',
    };

    test('fromJson creates EventModel correctly', () {
      final result = EventModel.fromJson(testEventJson);

      expect(result.id, equals('1'));
      expect(result.name, equals('Vaccination'));
      expect(result.petId, equals('pet1'));
      expect(result.description, equals('Annual vaccination for Buddy'));
      expect(result.date, equals(testDate));
      expect(result.location, equals('Veterinary Clinic'));
    });

    test('toJson converts EventModel to JSON correctly', () {
      final result = testEventModel.toJson();

      expect(result, equals(testEventJson));
    });

    test('fromEntity creates EventModel from Event entity', () {
      final event = Event(
        id: '2',
        name: 'Grooming',
        petId: 'pet2',
        description: 'Bath and grooming session',
        date: testDate,
        location: 'Pet Salon',
      );

      final result = EventModel.fromEntity(event);

      expect(result.id, equals('2'));
      expect(result.name, equals('Grooming'));
      expect(result.petId, equals('pet2'));
      expect(result.description, equals('Bath and grooming session'));
      expect(result.date, equals(testDate));
      expect(result.location, equals('Pet Salon'));
    });

    test('EventModel extends Event correctly', () {
      expect(testEventModel, isA<Event>());
    });

    test('two EventModels with same data are equal', () {
      final event1 = EventModel(
        id: '1',
        name: 'Vaccination',
        petId: 'pet1',
        description: 'Annual vaccination',
        date: testDate,
        location: 'Veterinary Clinic',
      );

      final event2 = EventModel(
        id: '1',
        name: 'Vaccination',
        petId: 'pet1',
        description: 'Annual vaccination',
        date: testDate,
        location: 'Veterinary Clinic',
      );

      expect(event1, equals(event2));
    });

    test('roundtrip conversion: toJson and fromJson', () {
      final json = testEventModel.toJson();
      final result = EventModel.fromJson(json);

      expect(result.id, equals(testEventModel.id));
      expect(result.name, equals(testEventModel.name));
      expect(result.petId, equals(testEventModel.petId));
      expect(result.description, equals(testEventModel.description));
      expect(result.location, equals(testEventModel.location));
    });

    test('fromJson parses DateTime correctly', () {
      final dateString = '2024-10-19T14:30:00.000Z';
      final json = {
        'id': '1',
        'name': 'Test Event',
        'petId': 'pet1',
        'description': 'Test description',
        'date': dateString,
        'location': 'Test Location',
      };

      final result = EventModel.fromJson(json);

      expect(result.date, equals(DateTime.parse(dateString)));
    });
  });
}
