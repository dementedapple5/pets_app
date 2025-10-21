import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pets_app/presentation/ui/utils/image_utils.dart';

void main() {
  group('ImageUtils Tests', () {
    testWidgets('should return placeholder widget for empty image path', (
      WidgetTester tester,
    ) async {
      const imagePath = '';
      const width = 100.0;
      const height = 100.0;

      final widget = ImageUtils.getImageWidget(
        imagePath: imagePath,
        width: width,
        height: height,
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      expect(find.byIcon(Icons.image_not_supported), findsOneWidget);

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.constraints?.maxWidth, equals(width));
      expect(container.constraints?.maxHeight, equals(height));
    });

    testWidgets('should return CachedNetworkImage for network URL', (
      WidgetTester tester,
    ) async {
      const imagePath = 'https://example.com/image.jpg';
      const width = 200.0;
      const height = 150.0;

      final widget = ImageUtils.getImageWidget(
        imagePath: imagePath,
        width: width,
        height: height,
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('should return Image.file for local file path', (
      WidgetTester tester,
    ) async {
      const imagePath = '/path/to/local/image.jpg';
      const width = 200.0;
      const height = 150.0;

      final widget = ImageUtils.getImageWidget(
        imagePath: imagePath,
        width: width,
        height: height,
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should use custom BoxFit when provided', (
      WidgetTester tester,
    ) async {
      const imagePath = 'https://example.com/image.jpg';
      const width = 200.0;
      const height = 150.0;
      const fit = BoxFit.contain;

      final widget = ImageUtils.getImageWidget(
        imagePath: imagePath,
        width: width,
        height: height,
        fit: fit,
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      final cachedImage = tester.widget<CachedNetworkImage>(
        find.byType(CachedNetworkImage),
      );
      expect(cachedImage.fit, equals(fit));
    });

    test('should correctly identify network images', () {
      expect(
        ImageUtils.isNetworkImage('https://example.com/image.jpg'),
        isTrue,
      );
      expect(ImageUtils.isNetworkImage('http://example.com/image.jpg'), isTrue);
      expect(ImageUtils.isNetworkImage('/path/to/local/image.jpg'), isFalse);
      expect(ImageUtils.isNetworkImage(''), isFalse);
    });

    testWidgets(
      'should show loading indicator in CachedNetworkImage placeholder',
      (WidgetTester tester) async {
        const imagePath = 'https://example.com/image.jpg';
        const width = 200.0;
        const height = 150.0;

        final widget = ImageUtils.getImageWidget(
          imagePath: imagePath,
          width: width,
          height: height,
        );

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

        // The placeholder should show a loading indicator
        final cachedImage = tester.widget<CachedNetworkImage>(
          find.byType(CachedNetworkImage),
        );
        expect(cachedImage.placeholder, isNotNull);
      },
    );

    testWidgets('should show error widget in CachedNetworkImage errorWidget', (
      WidgetTester tester,
    ) async {
      const imagePath = 'https://example.com/image.jpg';
      const width = 200.0;
      const height = 150.0;

      final widget = ImageUtils.getImageWidget(
        imagePath: imagePath,
        width: width,
        height: height,
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      // The error widget should show a broken image icon
      final cachedImage = tester.widget<CachedNetworkImage>(
        find.byType(CachedNetworkImage),
      );
      expect(cachedImage.errorWidget, isNotNull);
    });

    testWidgets('should show error widget in Image.file errorBuilder', (
      WidgetTester tester,
    ) async {
      const imagePath = '/path/to/local/image.jpg';
      const width = 200.0;
      const height = 150.0;

      final widget = ImageUtils.getImageWidget(
        imagePath: imagePath,
        width: width,
        height: height,
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      // The error builder should show a broken image icon
      final image = tester.widget<Image>(find.byType(Image));
      expect(image.errorBuilder, isNotNull);
    });
  });
}
