// lib/tabs/search_view.dart

import 'package:flutter/material.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _controller = TextEditingController();
  String selectedVimeoId = '';

  final List<Map<String, String>> videoList = [
    {"title": "Flutter Basics", "vimeoId": "76979871"},
    {"title": "Firebase Integration", "vimeoId": "22439234"},
    {"title": "Responsive UI", "vimeoId": "39528713"},
    {"title": "State Management", "vimeoId": "56473829"},
    {"title": "Animations", "vimeoId": "12783429"},
    {"title": "Login Screen", "vimeoId": "90847571"},
    {"title": "Dark Mode Setup", "vimeoId": "33327883"},
    {"title": "Register Page", "vimeoId": "31984719"},
    {"title": "Bottom Navigation", "vimeoId": "19283746"},
    {"title": "Bloc Pattern", "vimeoId": "49818383"},
  ];

  List<Map<String, String>> filteredList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final keyword = _controller.text.toLowerCase();
    setState(() {
      filteredList = videoList
          .where((video) => video['title']!.toLowerCase().contains(keyword))
          .toList();
    });
  }

  void _playVideo(String vimeoId) {
    setState(() => selectedVimeoId = vimeoId);
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Field
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Search videos...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // Autocomplete Suggestions / Results
        Expanded(
          child: _controller.text.isEmpty
              ? const Center(child: Text('Start typing to search'))
              : filteredList.isEmpty
              ? const Center(child: Text('No results found'))
              : ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final video = filteredList[index];
              return ListTile(
                title: Text(video['title']!),
                leading: const Icon(Icons.play_circle_outline),
                onTap: () => _playVideo(video['vimeoId']!),
              );
            },
          ),
        ),

        // Video Player
        if (selectedVimeoId.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: VimeoVideoPlayer(
              videoId: selectedVimeoId,
              isAutoPlay: true,
              isLooping: false,
            ),
          ),
      ],
    );
  }
}
