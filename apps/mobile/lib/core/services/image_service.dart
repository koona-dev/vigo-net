import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ImageService {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<List<String>> uploadFiles({
    required String ref,
    required List<File?> files,
  }) async {
    var imageUrls = await Future.wait(
      files.map(
        (image) => _putSingleFile(
          ref: ref,
          file: image,
        ),
      ),
    );
    return imageUrls;
  }

  Future<String> _putSingleFile({
    required String ref,
    required File? file,
  }) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
