import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pets_app/domain/entities/event.dart';
import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/presentation/blocs/pet_details/pet_details_cubit.dart';
import 'package:pets_app/presentation/blocs/pet_details/pet_details_state.dart';
import 'package:pets_app/presentation/ui/pages/pet_details_page.dart';
import 'package:pets_app/l10n/app_localizations.dart';

class MockPetDetailsCubit extends Mock implements PetDetailsCubit {}

void main() {
  group('PetDetailsPage Widget Tests', () {
    late MockPetDetailsCubit mockCubit;
    late Pet testPet;
    late Event testEvent;
    late PetDetailsState initialState;

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
        imageUrl: 'https://example.com/image.jpg',
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
      initialState = PetDetailsState(
        pet: testPet,
        events: [testEvent],
        isLoading: false,
        isPetDeleted: false,
        isPetEdited: false,
        isEventAdded: false,
        isEventUpdated: false,
        isEventDeleted: false,
      );
    });

    Widget createTestWidget({PetDetailsState? state}) {
      when(
        () => mockCubit.stream,
      ).thenAnswer((_) => Stream.value(state ?? initialState));
      when(() => mockCubit.state).thenReturn(state ?? initialState);

      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider<PetDetailsCubit>(
          create: (context) => mockCubit,
          child: PetDetailsPage(pet: testPet),
        ),
      );
    }

    testWidgets('should display pet name in app bar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Buddy'), findsOneWidget);
    });

    testWidgets('should display edit, delete, and add action buttons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byIcon(Icons.edit), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should display pet information', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Buddy'), findsWidgets);
      expect(find.text('Dog'), findsOneWidget);
      expect(find.text('Golden Retriever'), findsOneWidget);
      expect(find.text('Male'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('25.5'), findsOneWidget);
    });

    testWidgets('should display events section', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Events'), findsOneWidget);
    });

    testWidgets('should display events when available', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Vet Visit'), findsOneWidget);
      expect(find.text('Annual checkup'), findsOneWidget);
      expect(find.text('Animal Hospital'), findsOneWidget);
    });

    testWidgets('should display no events message when events list is empty', (
      WidgetTester tester,
    ) async {
      final emptyState = initialState.copyWith(events: []);
      await tester.pumpWidget(createTestWidget(state: emptyState));

      expect(find.text('No events yet'), findsOneWidget);
    });

    testWidgets('should display loading indicator when loading', (
      WidgetTester tester,
    ) async {
      final loadingState = initialState.copyWith(isLoading: true);
      await tester.pumpWidget(createTestWidget(state: loadingState));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
      'should show edit pet bottom sheet when edit button is pressed',
      (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        await tester.tap(find.byIcon(Icons.edit));
        await tester.pumpAndSettle();

        expect(find.byType(BottomSheet), findsOneWidget);
      },
    );

    testWidgets('should show delete pet dialog when delete button is pressed', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Delete Pet'), findsOneWidget);
    });

    testWidgets(
      'should show add event bottom sheet when add button is pressed',
      (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();

        expect(find.byType(BottomSheet), findsOneWidget);
      },
    );

    testWidgets(
      'should show edit event bottom sheet when event menu is opened',
      (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Find and tap the more_vert icon in the event card
        await tester.tap(find.byIcon(Icons.more_vert));
        await tester.pumpAndSettle();

        // Tap edit option
        await tester.tap(find.text('Edit'));
        await tester.pumpAndSettle();

        expect(find.byType(BottomSheet), findsOneWidget);
      },
    );

    testWidgets(
      'should show delete event dialog when delete option is selected',
      (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Find and tap the more_vert icon in the event card
        await tester.tap(find.byIcon(Icons.more_vert));
        await tester.pumpAndSettle();

        // Tap delete option
        await tester.tap(find.text('Delete'));
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Delete Event'), findsOneWidget);
      },
    );

    testWidgets('should display pet image when imageUrl is provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      // Should find an image widget (could be CachedNetworkImage or similar)
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should display placeholder when no image is provided', (
      WidgetTester tester,
    ) async {
      final petWithoutImage = Pet(
        id: testPet.id,
        name: testPet.name,
        species: testPet.species,
        breed: testPet.breed,
        gender: testPet.gender,
        age: testPet.age,
        weight: testPet.weight,
        imageUrl: '',
      );
      final stateWithoutImage = initialState.copyWith(pet: petWithoutImage);
      await tester.pumpWidget(createTestWidget(state: stateWithoutImage));

      expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
    });

    testWidgets('should call deletePet when delete is confirmed in dialog', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Delete'));
      await tester.pump();

      verify(() => mockCubit.deletePet()).called(1);
    });

    testWidgets(
      'should call deleteEvent when event delete is confirmed in dialog',
      (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        await tester.tap(find.byIcon(Icons.more_vert));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Delete'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Delete'));
        await tester.pump();

        verify(() => mockCubit.deleteEvent('event1')).called(1);
      },
    );

    testWidgets('should show snackbar when pet is deleted successfully', (
      WidgetTester tester,
    ) async {
      final deletedState = initialState.copyWith(isPetDeleted: true);
      when(
        () => mockCubit.stream,
      ).thenAnswer((_) => Stream.value(deletedState));
      when(() => mockCubit.state).thenReturn(deletedState);

      await tester.pumpWidget(createTestWidget(state: deletedState));
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('should show snackbar when pet is edited successfully', (
      WidgetTester tester,
    ) async {
      final editedState = initialState.copyWith(isPetEdited: true);
      when(() => mockCubit.stream).thenAnswer((_) => Stream.value(editedState));
      when(() => mockCubit.state).thenReturn(editedState);

      await tester.pumpWidget(createTestWidget(state: editedState));
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('should show snackbar when event is added successfully', (
      WidgetTester tester,
    ) async {
      final eventAddedState = initialState.copyWith(isEventAdded: true);
      when(
        () => mockCubit.stream,
      ).thenAnswer((_) => Stream.value(eventAddedState));
      when(() => mockCubit.state).thenReturn(eventAddedState);

      await tester.pumpWidget(createTestWidget(state: eventAddedState));
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('should show snackbar when event is updated successfully', (
      WidgetTester tester,
    ) async {
      final eventUpdatedState = initialState.copyWith(isEventUpdated: true);
      when(
        () => mockCubit.stream,
      ).thenAnswer((_) => Stream.value(eventUpdatedState));
      when(() => mockCubit.state).thenReturn(eventUpdatedState);

      await tester.pumpWidget(createTestWidget(state: eventUpdatedState));
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('should show snackbar when event is deleted successfully', (
      WidgetTester tester,
    ) async {
      final eventDeletedState = initialState.copyWith(isEventDeleted: true);
      when(
        () => mockCubit.stream,
      ).thenAnswer((_) => Stream.value(eventDeletedState));
      when(() => mockCubit.state).thenReturn(eventDeletedState);

      await tester.pumpWidget(createTestWidget(state: eventDeletedState));
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('should format date and time correctly in event cards', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      // Should display formatted date/time
      expect(find.textContaining('15/01/2024'), findsOneWidget);
    });

    testWidgets('should display event description with ellipsis when long', (
      WidgetTester tester,
    ) async {
      final longDescriptionEvent = Event(
        id: testEvent.id,
        name: testEvent.name,
        petId: testEvent.petId,
        description:
            'This is a very long description that should be truncated with ellipsis when displayed in the event card',
        date: testEvent.date,
        location: testEvent.location,
        notificationEnabled: testEvent.notificationEnabled,
      );
      final stateWithLongDescription = initialState.copyWith(
        events: [longDescriptionEvent],
      );
      await tester.pumpWidget(
        createTestWidget(state: stateWithLongDescription),
      );

      final textWidget = tester.widget<Text>(
        find.textContaining('This is a very long description'),
      );
      expect(textWidget.maxLines, equals(2));
      expect(textWidget.overflow, equals(TextOverflow.ellipsis));
    });

    testWidgets('should display event location with ellipsis when long', (
      WidgetTester tester,
    ) async {
      final longLocationEvent = Event(
        id: testEvent.id,
        name: testEvent.name,
        petId: testEvent.petId,
        description: testEvent.description,
        date: testEvent.date,
        location: 'This is a very long location name that should be truncated',
        notificationEnabled: testEvent.notificationEnabled,
      );
      final stateWithLongLocation = initialState.copyWith(
        events: [longLocationEvent],
      );
      await tester.pumpWidget(createTestWidget(state: stateWithLongLocation));

      final textWidget = tester.widget<Text>(
        find.textContaining('This is a very long location'),
      );
      expect(textWidget.maxLines, equals(1));
      expect(textWidget.overflow, equals(TextOverflow.ellipsis));
    });
  });
}
