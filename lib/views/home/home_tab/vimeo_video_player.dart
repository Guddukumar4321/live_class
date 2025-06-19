import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoId;
  final String title;

  const VideoPlayerPage({super.key, required this.videoId, required this.title});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  bool isVideoLoading = true;
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Stack(
        children: [
          VimeoVideoPlayer(
            videoId: widget.videoId,
            isAutoPlay: true,
            onInAppWebViewCreated: (controller) => webViewController = controller,
            onInAppWebViewLoadStart: (_, __) => setState(() => isVideoLoading = true),
            onInAppWebViewLoadStop: (_, __) => setState(() => isVideoLoading = false),
          ),
          if (isVideoLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    webViewController?.dispose();
    super.dispose();
  }
}
