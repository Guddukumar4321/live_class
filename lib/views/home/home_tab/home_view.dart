import 'package:flutter/material.dart';
import 'package:live_classroom/views/home/home_tab/vimeo_video_player.dart';

class HomeView extends StatelessWidget {
   HomeView({super.key});

  final List<Map<String, String>> videos = [
    {
      "title": "The Mountains Are Calling",
      "vimeoId": "76979871",
      "thumbnail": "https://i.vimeocdn.com/video/452001751_640.jpg",
    },
    {
      "title": "A Journey Through the Forest",
      "vimeoId": "148751763",
      "thumbnail": "https://i.vimeocdn.com/video/549872720_640.jpg",
    },
    {
      "title": "Skate Dreams",
      "vimeoId": "22439234",
      "thumbnail": "https://i.vimeocdn.com/video/143941177_640.jpg",
    },
    {
      "title": "Time in Tokyo",
      "vimeoId": "36248158",
      "thumbnail": "https://i.vimeocdn.com/video/289104240_640.jpg",
    },
    {
      "title": "Aerial Cinematics",
      "vimeoId": "18150336",
      "thumbnail": "https://i.vimeocdn.com/video/118911465_640.jpg",
    },
    {
      "title": "The Explorers",
      "vimeoId": "209858894",
      "thumbnail": "https://i.vimeocdn.com/video/613847480_640.jpg",
    },
    {
      "title": "City Nights",
      "vimeoId": "12345678",
      "thumbnail": "https://i.vimeocdn.com/video/407945276_640.jpg",
    },
    {
      "title": "Surfing the Waves",
      "vimeoId": "76979871",
      "thumbnail": "https://i.vimeocdn.com/video/452001751_640.jpg",
    },
    {
      "title": "Nature Time-lapse",
      "vimeoId": "186985168",
      "thumbnail": "https://i.vimeocdn.com/video/601731004_640.jpg",
    },
    {
      "title": "Sky Adventures",
      "vimeoId": "219727523",
      "thumbnail": "https://i.vimeocdn.com/video/637424999_640.jpg",
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Videos")),
      body: ListView.builder(
        itemCount: videos.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final video = videos[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => VideoPlayerPage(
                  videoId: video["vimeoId"]!,
                  title: video["title"]!,
                ),
              ));
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      video["thumbnail"]!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      video["title"]!,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
