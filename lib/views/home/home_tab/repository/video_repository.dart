import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../models/video_model.dart';

class VideoRepository {
  final FirebaseFirestore firestore;

  VideoRepository(this.firestore);

  Future<List<VideoModel>> fetchVideos() async {
    final snapshot = await firestore.collection('videos').get();
    return snapshot.docs
        .map((doc) => VideoModel.fromJson(doc.data()))
        .toList();
  }
}
