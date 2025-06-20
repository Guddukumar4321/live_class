import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../models/user_model.dart';

class SettingsRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<UserModel> fetchUserProfile() async {
    final uid = auth.currentUser!.uid;
    final doc = await firestore.collection('live_class_users').doc(uid).get();
    return UserModel.fromJson(doc.data()!);
  }

  Future<String> uploadProfilePicture(File imageFile) async {
    final uid = auth.currentUser!.uid;
    final ref = storage.ref().child('profile_pictures/$uid.jpg');
    await ref.putFile(imageFile);
    final url = await ref.getDownloadURL();
    await firestore.collection('live_class_users').doc(uid).update({'profilePicUrl': url});
    return url;
  }

  Future<void> changePassword(String newPassword) async {
    await auth.currentUser!.updatePassword(newPassword);
  }
}
