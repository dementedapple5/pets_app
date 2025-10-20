import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'package:pets_app/presentation/ui/utils/image_storage_service.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<String?> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image == null) return null;

      final String? permanentPath =
          await ImageStorageService.saveImagePermanently(image.path);
      return permanentPath;
    } catch (e) {
      log('Error picking image: $e');
      return null;
    }
  }
}
