import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../models/video_model.dart';

class VideoRepository {
  final _collection = FirebaseFirestore.instance.collection('videos');

  Future<List<VideoModel>> fetchVideos() async {
    final snapshot = await _collection.get();
    return snapshot.docs.map((doc) => VideoModel.fromJson(doc.data())).toList();
  }
}
