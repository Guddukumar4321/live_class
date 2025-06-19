
import 'package:flutter/material.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';

import '../../../core/theme/app_theme.dart';
import '../../../utilites/text_style.dart';



class HomeView extends StatelessWidget {
  const HomeView({super.key});

  final List<Map<String, String>> videos = const [
    {
      "title": "Flutter Basics",
      "vimeoId": "76979871", // Example public Vimeo video
    },
    {
      "title": "Firebase Integration",
      "vimeoId": "22439234",
    },
    {
      "title": "Responsive UI",
      "vimeoId": "39528713",
    },
    {
      "title": "State Management",
      "vimeoId": "56473829",
    },
    {
      "title": "Animations in Flutter",
      "vimeoId": "12783429",
    },
    {
      "title": "Dark Theme Setup",
      "vimeoId": "33327883",
    },
    {
      "title": "Navigation Basics",
      "vimeoId": "22231890",
    },
    {
      "title": "Login UI",
      "vimeoId": "90847571",
    },
    {
      "title": "Register Page",
      "vimeoId": "31984719",
    },
    {
      "title": "Video Player Integration",
      "vimeoId": "11239847",
    },
    {
      "title": "Building UI in Flutter",
      "vimeoId": "77684893",
    },
    {
      "title": "Working with Lists",
      "vimeoId": "65920384",
    },
    {
      "title": "Firebase Auth",
      "vimeoId": "81274637",
    },
    {
      "title": "Bloc Pattern",
      "vimeoId": "49818383",
    },
    {
      "title": "Form Validation",
      "vimeoId": "12348748",
    },
    {
      "title": "App Themes",
      "vimeoId": "77839210",
    },
    {
      "title": "Bottom Navigation",
      "vimeoId": "19283746",
    },
    {
      "title": "Drawer Navigation",
      "vimeoId": "21837498",
    },
    {
      "title": "Hero Animations",
      "vimeoId": "34838293",
    },
    {
      "title": "Flutter Hooks",
      "vimeoId": "73838302",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            return SizedBox(
              height: 200,
              child: Card(
                margin: const EdgeInsets.only(bottom: 16),
                color: AppColors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VimeoVideoPlayer(
                      videoId: video["vimeoId"]!,
                      isAutoPlay: false,
                      isLooping: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        video["title"]!,
                        style: AppTextStyles.body.copyWith(color: AppColors.black),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
