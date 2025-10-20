import 'dart:developer';

import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<String?> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      return image?.path;
    } catch (e) {
      log('Error picking image from camera: $e');
      return null;
    }
  }

  static Future<String?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      return image?.path;
    } catch (e) {
      log('Error picking image from gallery: $e');
      return null;
    }
  }

  static Future<String?> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      return image?.path;
    } catch (e) {
      log('Error picking image: $e');
      return null;
    }
  }
}
