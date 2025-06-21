/*
// live_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../models/live_session_model.dart';
import '../../../../utils/jwt_utils.dart';

class LiveRepository {
  final _doc = FirebaseFirestore.instance.collection('liveSessions').doc('status');

  Future<LiveSessionModel?> getLiveSession() async {
    final snap = await _doc.get();
    if (!snap.exists || !(snap.data()?['isLive'] ?? false)) return null;
    return LiveSessionModel.fromMap(snap.data()!);
  }

  Future<LiveSessionModel> createLiveSession() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final meetingId = DateTime.now().millisecondsSinceEpoch.toString();
    final token = JwtUtils.generateZoomToken(meetingId);

    final data = {
      'isLive': true,
      'hostUid': uid,
      'meetingId': meetingId,
      'token': token,
      'createdAt': FieldValue.serverTimestamp(),
    };

    await _doc.set(data);
    return LiveSessionModel.fromMap({
      ...data,
      'createdAt': DateTime.now(),
    });
  }

  Future<void> endLiveSession() async {
    await _doc.set({'isLive': false}, SetOptions(merge: true));
  }
}
*/
