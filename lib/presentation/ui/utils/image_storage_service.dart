import 'dart:io';
import 'dart:developer';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageStorageService {
  static Future<String?> saveImagePermanently(String tempImagePath) async {
    try {
      final Directory appDocDir = await getApplicationDocumentsDirectory();

      final Directory petsImagesDir = Directory('${appDocDir.path}/pet_images');
      if (!await petsImagesDir.exists()) {
        await petsImagesDir.create(recursive: true);
      }

      final File tempFile = File(tempImagePath);
      if (!await tempFile.exists()) {
        log('Temp file does not exists: $tempImagePath');
        return null;
      }

      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String extension = path.extension(tempImagePath);
      final String newFileName = 'pet_$timestamp$extension';
      final String newPath = '${petsImagesDir.path}/$newFileName';

      final File newFile = await tempFile.copy(newPath);

      log('Image saved permanently in: ${newFile.path}');
      return newFile.path;
    } catch (e) {
      log('Error saving the image permanently: $e');
      return null;
    }
  }

  static Future<bool> deleteImage(String imagePath) async {
    try {
      final File file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
        log('Image deleted: $imagePath');
        return true;
      }
      return false;
    } catch (e) {
      log('Error deleting the image: $e');
      return false;
    }
  }

  static bool isLocalImage(String imagePath) {
    return imagePath.contains('/pet_images/') || File(imagePath).existsSync();
  }

  static bool isNetworkImage(String imagePath) {
    return imagePath.startsWith('http://') || imagePath.startsWith('https://');
  }
}
