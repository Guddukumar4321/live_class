import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LiveView extends StatefulWidget {
  const LiveView({super.key});

  @override
  State<LiveView> createState() => _LiveViewState();
}

class _LiveViewState extends State<LiveView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String liveDocId = 'current_live_status'; // Singleton live doc
  bool isLoading = true;
  bool isLive = false;
  String? hostId;
  String? meetingId;

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    checkLiveStatus();
  }

  Future<void> checkLiveStatus() async {
    final doc = await _firestore.collection('live_sessions').doc(liveDocId).get();
    if (doc.exists) {
      setState(() {
        isLive = doc['isLive'] ?? false;
        hostId = doc['hostId'];
        meetingId = doc['meetingId'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLive = false;
        isLoading = false;
      });
    }
  }

  Future<void> goLive() async {
    final newMeetingId = DateTime.now().millisecondsSinceEpoch.toString(); // Simulated ID
    await _firestore.collection('live_sessions').doc(liveDocId).set({
      'isLive': true,
      'hostId': currentUser?.uid,
      'meetingId': newMeetingId,
      'timestamp': FieldValue.serverTimestamp(),
    });
    setState(() {
      isLive = true;
      hostId = currentUser?.uid;
      meetingId = newMeetingId;
    });

    // TODO: Launch Zoom Host Meeting via SDK
    debugPrint("Starting Live Meeting as Host");
  }

  Future<void> joinLive() async {
    // TODO: Launch Zoom Join Meeting via SDK
    debugPrint("Joining Meeting ID: $meetingId");
  }

  Widget _buildButton() {
    if (!isLive) {
      return ElevatedButton(
        onPressed: goLive,
        child: const Text("Go Live"),
      );
    } else if (hostId == currentUser?.uid) {
      return const Text("You are Live Now", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
    } else {
      return ElevatedButton(
        onPressed: joinLive,
        child: const Text("Join Live"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? const CircularProgressIndicator()
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isLive ? Icons.wifi_tethering : Icons.videocam_off,
            size: 80,
            color: isLive ? Colors.redAccent : Colors.grey,
          ),
          const SizedBox(height: 20),
          _buildButton(),
        ],
      ),
    );
  }
}
