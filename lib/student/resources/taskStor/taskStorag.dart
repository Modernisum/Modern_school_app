import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class TaskStorage {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> uploadTask() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final imageName = basename(pickedFile.path);
      print('Selected image: $imageName');

      try {
        final refStorage =
            _storage.ref('tasks/$imageName').child(_auth.currentUser!.uid);
        await refStorage.putFile(file);
        final downloadUrl = await refStorage.getDownloadURL();
        print('Download URL: $downloadUrl');
        return downloadUrl;
      } on FirebaseException catch (e) {
        print('Error uploading task: ${e.message}');
        return null; // Return null in case of error
      }
    } else {
      print('No image selected.');
      return null; // Return null if no image is selected
    }
  }
}
