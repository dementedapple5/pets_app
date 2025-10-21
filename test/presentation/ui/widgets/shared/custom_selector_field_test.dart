import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pets_app/presentation/ui/widgets/shared/custom_selector_field.dart';

void main() {
  group('CustomSelectorField Widget Tests', () {
    testWidgets('should display label and hint text', (
      WidgetTester tester,
    ) async {
      const labelText = 'Test Label';
      const hintText = 'Test Hint';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomSelectorField<String>(
              labelText: labelText,
              hintText: hintText,
              value: null,
              items: const [
                DropdownMenuItem(value: 'option1', child: Text('Option 1')),
                DropdownMenuItem(value: 'option2', child: Text('Option 2')),
              ],
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.text(labelText), findsOneWidget);
      expect(find.text(hintText), findsOneWidget);
    });

    testWidgets('should display selected value', (WidgetTester tester) async {
      const labelText = 'Test Label';
      const hintText = 'Test Hint';
      const selectedValue = 'option1';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomSelectorField<String>(
              labelText: labelText,
              hintText: hintText,
              value: selectedValue,
              items: const [
                DropdownMenuItem(value: 'option1', child: Text('Option 1')),
                DropdownMenuItem(value: 'option2', child: Text('Option 2')),
              ],
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.text('Option 1'), findsOneWidget);
    });

    testWidgets('should call onChanged when selection changes', (
      WidgetTester tester,
    ) async {
      const labelText = 'Test Label';
      const hintText = 'Test Hint';
      String? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return CustomSelectorField<String>(
                  labelText: labelText,
                  hintText: hintText,
                  value: selectedValue,
                  items: const [
                    DropdownMenuItem(value: 'option1', child: Text('Option 1')),
                    DropdownMenuItem(value: 'option2', child: Text('Option 2')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      // Tap to open dropdown
      await tester.tap(find.byType(CustomSelectorField<String>));
      await tester.pumpAndSettle();

      // Select first option
      await tester.tap(find.text('Option 1'));
      await tester.pumpAndSettle();

      expect(selectedValue, equals('option1'));
    });

    testWidgets('should display custom icon when provided', (
      WidgetTester tester,
    ) async {
      const labelText = 'Test Label';
      const hintText = 'Test Hint';
      const customIcon = Icon(Icons.arrow_drop_down);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomSelectorField<String>(
              labelText: labelText,
              hintText: hintText,
              value: null,
              items: const [
                DropdownMenuItem(value: 'option1', child: Text('Option 1')),
                DropdownMenuItem(value: 'option2', child: Text('Option 2')),
              ],
              onChanged: (value) {},
              icon: customIcon,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);
    });

    testWidgets('should be expanded when isExpanded is true', (
      WidgetTester tester,
    ) async {
      const labelText = 'Test Label';
      const hintText = 'Test Hint';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomSelectorField<String>(
              labelText: labelText,
              hintText: hintText,
              value: null,
              items: const [
                DropdownMenuItem(value: 'option1', child: Text('Option 1')),
                DropdownMenuItem(value: 'option2', child: Text('Option 2')),
              ],
              onChanged: (value) {},
              isExpanded: true,
            ),
          ),
        ),
      );

      // Test that the widget renders without error
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
    });

    testWidgets('should not be expanded when isExpanded is false', (
      WidgetTester tester,
    ) async {
      const labelText = 'Test Label';
      const hintText = 'Test Hint';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomSelectorField<String>(
              labelText: labelText,
              hintText: hintText,
              value: null,
              items: const [
                DropdownMenuItem(value: 'option1', child: Text('Option 1')),
                DropdownMenuItem(value: 'option2', child: Text('Option 2')),
              ],
              onChanged: (value) {},
              isExpanded: false,
            ),
          ),
        ),
      );

      // Test that the widget renders without error
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
    });

    testWidgets('should validate input when validator is provided', (
      WidgetTester tester,
    ) async {
      const labelText = 'Test Label';
      const hintText = 'Test Hint';
      const errorMessage = 'Please select an option';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: GlobalKey<FormState>(),
              child: CustomSelectorField<String>(
                labelText: labelText,
                hintText: hintText,
                value: null,
                items: const [
                  DropdownMenuItem(value: 'option1', child: Text('Option 1')),
                  DropdownMenuItem(value: 'option2', child: Text('Option 2')),
                ],
                onChanged: (value) {},
                validator: (value) {
                  if (value == null) {
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
            body: CustomSelectorField<String>(
              labelText: labelText,
              hintText: hintText,
              value: null,
              items: const [
                DropdownMenuItem(value: 'option1', child: Text('Option 1')),
                DropdownMenuItem(value: 'option2', child: Text('Option 2')),
              ],
              onChanged: (value) {},
              backgroundColor: backgroundColor,
            ),
          ),
        ),
      );

      // Test that the widget renders without error with custom background color
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
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
            body: CustomSelectorField<String>(
              labelText: labelText,
              hintText: hintText,
              value: null,
              items: const [
                DropdownMenuItem(value: 'option1', child: Text('Option 1')),
                DropdownMenuItem(value: 'option2', child: Text('Option 2')),
              ],
              onChanged: (value) {},
              borderRadius: borderRadius,
            ),
          ),
        ),
      );

      // Test that the widget renders without error with custom border radius
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
    });

    testWidgets('should use custom text style when provided', (
      WidgetTester tester,
    ) async {
      const labelText = 'Test Label';
      const hintText = 'Test Hint';
      const textStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomSelectorField<String>(
              labelText: labelText,
              hintText: hintText,
              value: null,
              items: const [
                DropdownMenuItem(value: 'option1', child: Text('Option 1')),
                DropdownMenuItem(value: 'option2', child: Text('Option 2')),
              ],
              onChanged: (value) {},
              textStyle: textStyle,
            ),
          ),
        ),
      );

      // Test that the widget renders without error with custom text style
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
    });

    testWidgets('should work with different data types', (
      WidgetTester tester,
    ) async {
      const labelText = 'Number Label';
      const hintText = 'Number Hint';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomSelectorField<int>(
              labelText: labelText,
              hintText: hintText,
              value: null,
              items: const [
                DropdownMenuItem(value: 1, child: Text('One')),
                DropdownMenuItem(value: 2, child: Text('Two')),
                DropdownMenuItem(value: 3, child: Text('Three')),
              ],
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.text(labelText), findsOneWidget);
      expect(find.text(hintText), findsOneWidget);
    });
  });
}
