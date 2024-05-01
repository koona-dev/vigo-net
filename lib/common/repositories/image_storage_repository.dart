import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageStorageRepositoryProvider = Provider(
  (ref) => ImageStorageRepository(FirebaseStorage.instance),
);

class ImageStorageRepository {
  final FirebaseStorage firebaseStoreage;
  ImageStorageRepository(this.firebaseStoreage);

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
    UploadTask uploadTask = firebaseStoreage.ref().child(ref).putFile(file!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
