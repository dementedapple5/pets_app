import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageUtils {
  /// Check if the image URL is a network URL or a local file path
  static bool isNetworkImage(String imagePath) {
    return imagePath.startsWith('http://') || imagePath.startsWith('https://');
  }

  /// Get the appropriate image widget based on the image path
  static Widget getImageWidget({
    required String imagePath,
    required double width,
    required double height,
    BoxFit fit = BoxFit.cover,
  }) {
    if (imagePath.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: const Icon(Icons.image_not_supported),
      );
    }

    if (isNetworkImage(imagePath)) {
      return CachedNetworkImage(
        imageUrl: imagePath,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(Icons.broken_image),
        ),
      );
    } else {
      return Image.file(
        File(imagePath),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(Icons.broken_image),
        ),
      );
    }
  }

  static Widget getCircleAvatarImage(String imagePath) {
    if (imagePath.isEmpty) {
      return CircleAvatar(
        backgroundColor: Colors.grey[300],
        child: const Icon(Icons.pets),
      );
    }

    if (isNetworkImage(imagePath)) {
      return CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(imagePath),
      );
    } else {
      return CircleAvatar(backgroundImage: FileImage(File(imagePath)));
    }
  }
}
