import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/live_meeting_model.dart';

class LiveRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<LiveMeeting?> getLiveStatus() async {
    final doc = await _firestore.collection('live_meeting').doc('current').get();
    if (doc.exists && doc.data() != null) {
      return LiveMeeting.fromMap(doc.data()!);
    }
    return null;
  }

  Future<void> goLive(String uid, String meetingId, String passcode) async {
    await _firestore.collection('live_meeting').doc('current').set({
      'isLive': true,
      'hostUid': uid,
      'meetingId': meetingId,
      'passcode': passcode,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> endLive() async {
    await _firestore.collection('live_meeting').doc('current').set({
      'isLive': false,
      'hostUid': '',
      'meetingId': '',
      'passcode': '',
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
