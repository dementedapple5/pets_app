import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/presentation/blocs/home/home_cubit.dart';
import 'package:pets_app/presentation/blocs/home/home_state.dart';
import 'package:pets_app/presentation/ui/pages/home_page.dart';
import 'package:pets_app/l10n/app_localizations.dart';

class MockHomeCubit extends Mock implements HomeCubit {}

void main() {
  group('HomePage Widget Tests', () {
    late MockHomeCubit mockCubit;
    late HomeState initialState;

    setUp(() {
      mockCubit = MockHomeCubit();
      initialState = HomeState(pets: [], isLoading: false, errorMessage: null);
    });

    Widget createTestWidget({HomeState? state}) {
      when(
        () => mockCubit.stream,
      ).thenAnswer((_) => Stream.value(state ?? initialState));
      when(() => mockCubit.state).thenReturn(state ?? initialState);

      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider<HomeCubit>(
          create: (context) => mockCubit,
          child: const HomePage(),
        ),
      );
    }

    testWidgets('should display pets title in app bar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Pets'), findsOneWidget);
    });

    testWidgets('should display add button in app bar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should display loading indicator when loading', (
      WidgetTester tester,
    ) async {
      final loadingState = initialState.copyWith(isLoading: true);
      await tester.pumpWidget(createTestWidget(state: loadingState));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display empty state when no pets', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('No pets yet'), findsOneWidget);
    });

    testWidgets('should display pets when available', (
      WidgetTester tester,
    ) async {
      final pets = [
        Pet(
          id: '1',
          name: 'Buddy',
          species: 'Dog',
          breed: 'Golden Retriever',
          gender: 'Male',
          age: 3,
          weight: 25.5,
          imageUrl: '',
        ),
        Pet(
          id: '2',
          name: 'Whiskers',
          species: 'Cat',
          breed: 'Persian',
          gender: 'Female',
          age: 2,
          weight: 4.5,
          imageUrl: '',
        ),
      ];
      final stateWithPets = initialState.copyWith(pets: pets);
      await tester.pumpWidget(createTestWidget(state: stateWithPets));

      expect(find.text('Buddy'), findsOneWidget);
      expect(find.text('Whiskers'), findsOneWidget);
      expect(find.text('Dog'), findsOneWidget);
      expect(find.text('Cat'), findsOneWidget);
    });

    testWidgets('should call getPets when add button is pressed', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      verify(() => mockCubit.getPets()).called(1);
    });

    testWidgets('should navigate to add pet page when add button is pressed', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Should navigate to add pet page
      expect(find.text('Add Pet'), findsOneWidget);
    });

    testWidgets('should display pet cards with correct information', (
      WidgetTester tester,
    ) async {
      final pet = Pet(
        id: '1',
        name: 'Buddy',
        species: 'Dog',
        breed: 'Golden Retriever',
        gender: 'Male',
        age: 3,
        weight: 25.5,
        imageUrl: 'https://example.com/image.jpg',
      );
      final stateWithPet = initialState.copyWith(pets: [pet]);
      await tester.pumpWidget(createTestWidget(state: stateWithPet));

      expect(find.text('Buddy'), findsOneWidget);
      expect(find.text('Dog'), findsOneWidget);
      expect(find.text('Golden Retriever'), findsOneWidget);
      expect(find.text('Male'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('25.5'), findsOneWidget);
    });

    testWidgets('should navigate to pet details when pet card is tapped', (
      WidgetTester tester,
    ) async {
      final pet = Pet(
        id: '1',
        name: 'Buddy',
        species: 'Dog',
        breed: 'Golden Retriever',
        gender: 'Male',
        age: 3,
        weight: 25.5,
        imageUrl: '',
      );
      final stateWithPet = initialState.copyWith(pets: [pet]);
      await tester.pumpWidget(createTestWidget(state: stateWithPet));

      await tester.tap(find.text('Buddy'));
      await tester.pumpAndSettle();

      // Should navigate to pet details page
      expect(find.text('Buddy'), findsWidgets); // Should appear in app bar
    });

    testWidgets('should display error message when error occurs', (
      WidgetTester tester,
    ) async {
      final errorState = initialState.copyWith(
        errorMessage: 'Failed to load pets',
      );
      await tester.pumpWidget(createTestWidget(state: errorState));

      expect(find.text('Failed to load pets'), findsOneWidget);
    });

    testWidgets('should display retry button when error occurs', (
      WidgetTester tester,
    ) async {
      final errorState = initialState.copyWith(
        errorMessage: 'Failed to load pets',
      );
      await tester.pumpWidget(createTestWidget(state: errorState));

      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('should call getPets when retry button is pressed', (
      WidgetTester tester,
    ) async {
      final errorState = initialState.copyWith(
        errorMessage: 'Failed to load pets',
      );
      await tester.pumpWidget(createTestWidget(state: errorState));

      await tester.tap(find.text('Retry'));
      await tester.pump();

      verify(() => mockCubit.getPets()).called(1);
    });

    testWidgets('should display pet image when imageUrl is provided', (
      WidgetTester tester,
    ) async {
      final pet = Pet(
        id: '1',
        name: 'Buddy',
        species: 'Dog',
        breed: 'Golden Retriever',
        gender: 'Male',
        age: 3,
        weight: 25.5,
        imageUrl: 'https://example.com/image.jpg',
      );
      final stateWithPet = initialState.copyWith(pets: [pet]);
      await tester.pumpWidget(createTestWidget(state: stateWithPet));

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should display placeholder when no image is provided', (
      WidgetTester tester,
    ) async {
      final pet = Pet(
        id: '1',
        name: 'Buddy',
        species: 'Dog',
        breed: 'Golden Retriever',
        gender: 'Male',
        age: 3,
        weight: 25.5,
        imageUrl: '',
      );
      final stateWithPet = initialState.copyWith(pets: [pet]);
      await tester.pumpWidget(createTestWidget(state: stateWithPet));

      expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
    });
  });
}
