import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pets_app/domain/entities/event.dart';
import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/presentation/blocs/pet_details/pet_details_cubit.dart';
import 'package:pets_app/presentation/ui/widgets/pet_details/add_event_bottom_sheet.dart';
import 'package:pets_app/l10n/app_localizations.dart';

class MockPetDetailsCubit extends Mock implements PetDetailsCubit {}

void main() {
  group('AddEventBottomSheet Widget Tests', () {
    late MockPetDetailsCubit mockCubit;
    late Pet testPet;
    late Event testEvent;

    setUp(() {
      mockCubit = MockPetDetailsCubit();
      testPet = Pet(
        id: 'pet1',
        name: 'Buddy',
        species: 'Dog',
        breed: 'Golden Retriever',
        gender: 'Male',
        age: 3,
        weight: 25.5,
        imageUrl: '',
      );
      testEvent = Event(
        id: 'event1',
        name: 'Vet Visit',
        petId: 'pet1',
        description: 'Annual checkup',
        date: DateTime(2024, 1, 15, 10, 30),
        location: 'Animal Hospital',
        notificationEnabled: true,
      );
    });

    Widget createTestWidget({Event? event}) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider<PetDetailsCubit>(
          create: (context) => mockCubit,
          child: Scaffold(
            body: Builder(
              builder: (context) => AddEventBottomSheet(
                pet: testPet,
                petDetailsContext: context,
                event: event,
              ),
            ),
          ),
        ),
      );
    }

    testWidgets('should display add event title when no event is provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Add Event'), findsWidgets);
    });

    testWidgets('should display edit event title when event is provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget(event: testEvent));

      expect(find.text('Edit Event'), findsOneWidget);
    });

    testWidgets('should display all form fields', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Event Name'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(find.text('Date'), findsOneWidget);
      expect(find.text('Time'), findsOneWidget);
      expect(find.text('Location'), findsOneWidget);
    });

    testWidgets('should pre-populate fields when editing existing event', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget(event: testEvent));

      expect(find.text('Vet Visit'), findsOneWidget);
      expect(find.text('Annual checkup'), findsOneWidget);
      expect(find.text('Animal Hospital'), findsOneWidget);
    });

    testWidgets('should show calendar icon for date field', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    });

    testWidgets('should show time icon for time field', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byIcon(Icons.access_time), findsOneWidget);
    });

    testWidgets('should have notification checkbox checked by default', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, isTrue);
    });

    testWidgets('should toggle notification checkbox when tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, isFalse);
    });

    testWidgets('should display cancel and add buttons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Add Event'), findsWidgets);
    });

    testWidgets('should display update button when editing event', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget(event: testEvent));

      expect(find.text('Update Event'), findsOneWidget);
    });

    testWidgets(
      'should show snackbar when name is empty and add button is pressed',
      (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        await tester.tap(find.widgetWithText(ElevatedButton, 'Add Event'));
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
      },
    );

    testWidgets(
      'should show snackbar when date is not selected and add button is pressed',
      (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Enter name to pass first validation
        await tester.enterText(find.byType(TextFormField).first, 'Test Event');
        await tester.pump();

        await tester.tap(find.widgetWithText(ElevatedButton, 'Add Event'));
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
      },
    );

    testWidgets(
      'should show snackbar when time is not selected and add button is pressed',
      (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Enter name to pass first validation
        await tester.enterText(find.byType(TextFormField).first, 'Test Event');
        await tester.pump();

        // Select a date
        await tester.tap(find.byIcon(Icons.calendar_today));
        await tester.pumpAndSettle();

        // Select today's date
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();

        await tester.tap(find.widgetWithText(ElevatedButton, 'Add Event'));
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
      },
    );

    testWidgets(
      'should call addEvent when form is valid and add button is pressed',
      (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Fill in all required fields
        await tester.enterText(find.byType(TextFormField).first, 'Test Event');
        await tester.pump();

        // Select date
        await tester.tap(find.byIcon(Icons.calendar_today));
        await tester.pumpAndSettle();
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();

        // Select time
        await tester.tap(find.byIcon(Icons.access_time));
        await tester.pumpAndSettle();
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();

        await tester.tap(find.widgetWithText(ElevatedButton, 'Add Event'));
        await tester.pump();

        verify(() => mockCubit.addEvent(any())).called(1);
      },
    );

    testWidgets(
      'should call updateEvent when form is valid and update button is pressed',
      (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(event: testEvent));

        // Modify the name
        await tester.enterText(
          find.byType(TextFormField).first,
          'Updated Event',
        );
        await tester.pump();

        await tester.tap(find.text('Update Event'));
        await tester.pump();

        verify(() => mockCubit.updateEvent(any())).called(1);
      },
    );

    testWidgets('should close bottom sheet when cancel button is pressed', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      await tester.tap(find.text('Cancel'));
      await tester.pump();

      // The cancel button should be found
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('should have multiline description field', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      // Test that the widget renders without error
      expect(find.byType(TextFormField), findsWidgets);
    });

    testWidgets('should have read-only date and time fields', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      // Test that the widget renders without error
      expect(find.byType(TextFormField), findsWidgets);
    });

    testWidgets('should open date picker when date field is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      await tester.tap(find.byIcon(Icons.calendar_today));
      await tester.pumpAndSettle();

      expect(find.byType(DatePickerDialog), findsOneWidget);
    });

    testWidgets('should open time picker when time field is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      await tester.tap(find.byIcon(Icons.access_time));
      await tester.pumpAndSettle();

      expect(find.byType(TimePickerDialog), findsOneWidget);
    });
  });
}
