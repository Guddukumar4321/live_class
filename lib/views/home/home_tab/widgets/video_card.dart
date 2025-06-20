import 'package:flutter/material.dart';

import '../../../../models/video_model.dart';
import '../../../../widgets/custom_images.dart';
import '../vimeo_video_player.dart';

class VideoCard extends StatelessWidget {
  final VideoModel data;

  const VideoCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => VideoPlayerPage(
            videoId: data.vimeoId??"",
            title: data.title??"",
          ),
        ));
      },
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: CustomImage(
                path: data.thumbnailUrl??"",
                width: double.infinity,
                height: 200,
                isNetwork: true,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                data.title??"",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
