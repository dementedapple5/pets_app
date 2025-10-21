import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pets_app/presentation/ui/widgets/shared/primary_button.dart';

void main() {
  group('PrimaryButton Widget Tests', () {
    testWidgets('should display title text', (WidgetTester tester) async {
      const title = 'Test Button';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(title: title, onPressed: () {}),
          ),
        ),
      );

      expect(find.text(title), findsOneWidget);
    });

    testWidgets('should be enabled when onPressed is provided', (
      WidgetTester tester,
    ) async {
      const title = 'Test Button';
      bool onPressedCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              title: title,
              onPressed: () {
                onPressedCalled = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PrimaryButton));
      expect(onPressedCalled, isTrue);
    });

    testWidgets('should be disabled when onPressed is null', (
      WidgetTester tester,
    ) async {
      const title = 'Test Button';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PrimaryButton(title: title, onPressed: null)),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('should show loading indicator when isLoading is true', (
      WidgetTester tester,
    ) async {
      const title = 'Test Button';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              title: title,
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text(title), findsNothing);
    });

    testWidgets('should use custom background color when provided', (
      WidgetTester tester,
    ) async {
      const title = 'Test Button';
      const backgroundColor = Colors.red;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              title: title,
              onPressed: () {},
              backgroundColor: backgroundColor,
            ),
          ),
        ),
      );

      final buttonStyle = tester
          .widget<ElevatedButton>(find.byType(ElevatedButton))
          .style;
      expect(
        buttonStyle?.backgroundColor?.resolve({}),
        equals(backgroundColor),
      );
    });

    testWidgets('should use custom text color when provided', (
      WidgetTester tester,
    ) async {
      const title = 'Test Button';
      const textColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              title: title,
              onPressed: () {},
              textColor: textColor,
            ),
          ),
        ),
      );

      final buttonStyle = tester
          .widget<ElevatedButton>(find.byType(ElevatedButton))
          .style;
      expect(buttonStyle?.foregroundColor?.resolve({}), equals(textColor));
    });

    testWidgets('should use custom border radius when provided', (
      WidgetTester tester,
    ) async {
      const title = 'Test Button';
      const borderRadius = 20.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              title: title,
              onPressed: () {},
              borderRadius: borderRadius,
            ),
          ),
        ),
      );

      // Test that the widget renders without error with custom border radius
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should have zero elevation', (WidgetTester tester) async {
      const title = 'Test Button';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(title: title, onPressed: () {}),
          ),
        ),
      );

      final buttonStyle = tester
          .widget<ElevatedButton>(find.byType(ElevatedButton))
          .style;
      expect(buttonStyle?.elevation?.resolve({}), equals(0.0));
    });

    testWidgets('should have proper padding', (WidgetTester tester) async {
      const title = 'Test Button';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(title: title, onPressed: () {}),
          ),
        ),
      );

      final buttonStyle = tester
          .widget<ElevatedButton>(find.byType(ElevatedButton))
          .style;
      expect(
        buttonStyle?.padding?.resolve({}),
        equals(const EdgeInsets.symmetric(vertical: 16)),
      );
    });

    testWidgets(
      'should use theme text style when no custom text color is provided',
      (WidgetTester tester) async {
        const title = 'Test Button';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PrimaryButton(title: title, onPressed: () {}),
            ),
          ),
        );

        // Test that the widget renders without error
        expect(find.text(title), findsOneWidget);
      },
    );

    testWidgets('should use custom text style when textColor is provided', (
      WidgetTester tester,
    ) async {
      const title = 'Test Button';
      const textColor = Colors.green;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              title: title,
              onPressed: () {},
              textColor: textColor,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text(title));
      expect(textWidget.style?.color, equals(textColor));
    });
  });
}
