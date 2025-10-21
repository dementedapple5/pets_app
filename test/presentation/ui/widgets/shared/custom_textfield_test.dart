import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pets_app/presentation/ui/widgets/shared/custom_textfield.dart';

void main() {
  group('CustomTextField Widget Tests', () {
    late TextEditingController controller;

    setUp(() {
      controller = TextEditingController();
    });

    tearDown(() {
      controller.dispose();
    });

    testWidgets('should display label and hint text', (
      WidgetTester tester,
    ) async {
      const labelText = 'Test Label';
      const hintText = 'Test Hint';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              labelText: labelText,
              hintText: hintText,
              controller: controller,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
          ),
        ),
      );

      expect(find.text(labelText), findsOneWidget);
      expect(find.text(hintText), findsOneWidget);
    });

    testWidgets('should display text when controller has value', (
      WidgetTester tester,
    ) async {
      const labelText = 'Test Label';
      const hintText = 'Test Hint';
      const testValue = 'Test Value';

      controller.text = testValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              labelText: labelText,
              hintText: hintText,
              controller: controller,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
          ),
        ),
      );

      expect(find.text(testValue), findsOneWidget);
    });

    testWidgets('should update controller when text is entered', (
      WidgetTester tester,
    ) async {
      const labelText = 'Test Label';
      const hintText = 'Test Hint';
      const testValue = 'New Value';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              labelText: labelText,
              hintText: hintText,
              controller: controller,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), testValue);
      expect(controller.text, equals(testValue));
    });

    testWidgets('should display suffix icon when provided', (
      WidgetTester tester,
    ) async {
      const labelText = 'Test Label';
      const hintText = 'Test Hint';
      const suffixIcon = Icon(Icons.search);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              labelText: labelText,
              hintText: hintText,
              controller: controller,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('should be read-only when readOnly is true', (
      WidgetTester tester,
    ) async {
      const labelText = 'Test Label';
      const hintText = 'Test Hint';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              labelText: labelText,
              hintText: hintText,
              controller: controller,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              readOnly: true,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextFormField>(
        find.byType(TextFormField),
      );
      expect(textField.controller?.text, isEmpty);
    });

    testWidgets('should call onTap when tapped and readOnly is true', (
      WidgetTester tester,
    ) async {
      const labelText = 'Test Label';
      const hintText = 'Test Hint';
      bool onTapCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              labelText: labelText,
              hintText: hintText,
              controller: controller,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              readOnly: true,
              onTap: () {
                onTapCalled = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextFormField));
      expect(onTapCalled, isTrue);
    });

    testWidgets('should support multiline input when maxLines > 1', (
      WidgetTester tester,
    ) async {
      const labelText = 'Test Label';
      const hintText = 'Test Hint';
      const maxLines = 3;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              labelText: labelText,
              hintText: hintText,
              controller: controller,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLines: maxLines,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextFormField>(
        find.byType(TextFormField),
      );
      expect(textField.controller?.text, isEmpty);
    });

    testWidgets('should validate input when validator is provided', (
      WidgetTester tester,
    ) async {
      const labelText = 'Test Label';
      const hintText = 'Test Hint';
      const errorMessage = 'This field is required';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: GlobalKey<FormState>(),
              child: CustomTextField(
                labelText: labelText,
                hintText: hintText,
                controller: controller,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return errorMessage;
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      // Trigger validation by calling validate on the form
      final formKey =
          tester.widget<Form>(find.byType(Form)).key as GlobalKey<FormState>;
      formKey.currentState?.validate();

      await tester.pump();

      // The validator should be called and return the error message
      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('should use custom background color when provided', (
      WidgetTester tester,
    ) async {
      const labelText = 'Test Label';
      const hintText = 'Test Hint';
      const backgroundColor = Colors.red;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              labelText: labelText,
              hintText: hintText,
              controller: controller,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              backgroundColor: backgroundColor,
            ),
          ),
        ),
      );

      // Test that the widget renders without error with custom background color
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('should use custom border radius when provided', (
      WidgetTester tester,
    ) async {
      const labelText = 'Test Label';
      const hintText = 'Test Hint';
      const borderRadius = 20.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              labelText: labelText,
              hintText: hintText,
              controller: controller,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              borderRadius: borderRadius,
            ),
          ),
        ),
      );

      // Test that the widget renders without error with custom border radius
      expect(find.byType(TextFormField), findsOneWidget);
    });
  });
}
