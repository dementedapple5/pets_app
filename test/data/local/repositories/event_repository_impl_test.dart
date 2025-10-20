import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pets_app/data/local/db/event_local_data_source.dart';
import 'package:pets_app/data/local/models/event_model.dart';
import 'package:pets_app/data/local/models/get_events_response_model.dart';
import 'package:pets_app/data/local/repositories/event_repository_impl.dart';
import 'package:pets_app/domain/entities/event.dart';

class MockEventLocalDataSource extends Mock implements EventLocalDataSource {}

void main() {
  group('EventRepositoryImpl', () {
    late MockEventLocalDataSource mockEventLocalDataSource;
    late EventRepositoryImpl eventRepositoryImpl;

    setUpAll(() {
      final testDate = DateTime(2024, 10, 19, 10, 30);
      registerFallbackValue(
        EventModel(
          id: '',
          name: '',
          petId: '',
          description: '',
          date: testDate,
          location: '',
        ),
      );
    });

    setUp(() {
      mockEventLocalDataSource = MockEventLocalDataSource();
      eventRepositoryImpl = EventRepositoryImpl(
        eventLocalDataSource: mockEventLocalDataSource,
      );
    });

    final testDate = DateTime(2024, 10, 19, 10, 30);

    final testEventModel = EventModel(
      id: '1',
      name: 'Vaccination',
      petId: 'pet1',
      description: 'Annual vaccination for Buddy',
      date: testDate,
      location: 'Veterinary Clinic',
    );

    final testEvent = Event(
      id: '1',
      name: 'Vaccination',
      petId: 'pet1',
      description: 'Annual vaccination for Buddy',
      date: testDate,
      location: 'Veterinary Clinic',
    );

    group('getEventsByPetId', () {
      test('returns list of events when data source call succeeds', () async {
        final testResponse = GetEventsResponseModel(
          events: [testEventModel],
          errorMessage: '',
        );

        when(
          () => mockEventLocalDataSource.getEventsByPetId('pet1'),
        ).thenAnswer((_) async => testResponse);

        final result = await eventRepositoryImpl.getEventsByPetId('pet1');

        expect(result, equals([testEventModel]));
        verify(
          () => mockEventLocalDataSource.getEventsByPetId('pet1'),
        ).called(1);
      });

      test('returns empty list when no events exist', () async {
        final testResponse = GetEventsResponseModel(
          events: [],
          errorMessage: '',
        );

        when(
          () => mockEventLocalDataSource.getEventsByPetId('pet1'),
        ).thenAnswer((_) async => testResponse);

        final result = await eventRepositoryImpl.getEventsByPetId('pet1');

        expect(result, isEmpty);
        verify(
          () => mockEventLocalDataSource.getEventsByPetId('pet1'),
        ).called(1);
      });

      test('throws exception when data source fails', () async {
        when(
          () => mockEventLocalDataSource.getEventsByPetId('pet1'),
        ).thenThrow(Exception('Database error'));

        expect(
          () => eventRepositoryImpl.getEventsByPetId('pet1'),
          throwsException,
        );
        verify(
          () => mockEventLocalDataSource.getEventsByPetId('pet1'),
        ).called(1);
      });
    });

    group('addEvent', () {
      test('adds event successfully', () async {
        when(
          () => mockEventLocalDataSource.addEvent(any()),
        ).thenAnswer((_) async {});

        await eventRepositoryImpl.addEvent(testEvent);

        verify(() => mockEventLocalDataSource.addEvent(any())).called(1);
      });

      test('converts Event entity to EventModel before adding', () async {
        when(
          () => mockEventLocalDataSource.addEvent(any()),
        ).thenAnswer((_) async {});

        await eventRepositoryImpl.addEvent(testEvent);

        verify(
          () => mockEventLocalDataSource.addEvent(
            any(
              that: isA<EventModel>().having((m) => m.id, 'id', testEvent.id),
            ),
          ),
        ).called(1);
      });

      test('throws exception when data source fails', () async {
        when(
          () => mockEventLocalDataSource.addEvent(any()),
        ).thenThrow(Exception('Database error'));

        expect(() => eventRepositoryImpl.addEvent(testEvent), throwsException);
      });
    });

    group('deleteEvent', () {
      test('deletes event successfully', () async {
        when(
          () => mockEventLocalDataSource.deleteEvent('1'),
        ).thenAnswer((_) async {});

        await eventRepositoryImpl.deleteEvent('1');

        verify(() => mockEventLocalDataSource.deleteEvent('1')).called(1);
      });

      test('throws exception when data source fails', () async {
        when(
          () => mockEventLocalDataSource.deleteEvent('1'),
        ).thenThrow(Exception('Database error'));

        expect(() => eventRepositoryImpl.deleteEvent('1'), throwsException);
      });
    });

    group('updateEvent', () {
      test('updates event successfully', () async {
        when(
          () => mockEventLocalDataSource.updateEvent(any()),
        ).thenAnswer((_) async {});

        await eventRepositoryImpl.updateEvent(testEvent);

        verify(() => mockEventLocalDataSource.updateEvent(any())).called(1);
      });

      test('converts Event entity to EventModel before updating', () async {
        when(
          () => mockEventLocalDataSource.updateEvent(any()),
        ).thenAnswer((_) async {});

        await eventRepositoryImpl.updateEvent(testEvent);

        verify(
          () => mockEventLocalDataSource.updateEvent(
            any(
              that: isA<EventModel>().having((m) => m.id, 'id', testEvent.id),
            ),
          ),
        ).called(1);
      });

      test('throws exception when data source fails', () async {
        when(
          () => mockEventLocalDataSource.updateEvent(any()),
        ).thenThrow(Exception('Database error'));

        expect(
          () => eventRepositoryImpl.updateEvent(testEvent),
          throwsException,
        );
      });
    });
  });
}
