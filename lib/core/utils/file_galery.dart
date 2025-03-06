import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<List<File?>> pickImageFromGallery() async {
  List<File?> images = [];
  try {
    final pickedImage = await ImagePicker().pickMultiImage();
    images = pickedImage.map((image) => File(image.path)).toList();
  } catch (e) {
    print(e.toString());
  }
  return images;
}
