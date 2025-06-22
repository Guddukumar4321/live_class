import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../models/live_session_model.dart';

class LiveRepository {
  final _doc = FirebaseFirestore.instance.collection("live_session").doc("current");

  Future<LiveSessionModel?> getLiveSession() async {
    final snapshot = await _doc.get();
    if (!snapshot.exists || snapshot.data()?['status'] == 'idle') return null;
    return LiveSessionModel.fromMap(snapshot.data()!);
  }

  Future<void> startLive(String callId, String userId, String userName) async {
    await _doc.set({
      "status": "live",
      "host_uid": userId,
      "host_name": userName,
      "call_id": callId,
      "started_at": FieldValue.serverTimestamp(),
    });
  }

  Future<void> endLive() async {
    await _doc.update({"status": "idle"});
  }
}
