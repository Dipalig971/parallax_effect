import 'package:flutter/material.dart';
import 'package:parallax_effect/screen/parallax_effect/view/parallax_scrolling_screen.dart';
import 'package:video_player/video_player.dart';

class VideoCardScreen extends StatefulWidget {
  const VideoCardScreen(
      {super.key, required this.assetPath, required this.isSelected});

  final String assetPath;
  final bool isSelected;

  @override
  State<VideoCardScreen> createState() => _VideoCardScreenState();
}

class _VideoCardScreenState extends State<VideoCardScreen> {
  final GlobalKey videoKey = GlobalKey();
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.asset(widget.assetPath);

    videoPlayerController
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((value) => setState(() {}))
      ..play();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: widget.isSelected
          ? const EdgeInsets.symmetric(vertical: 16, horizontal: 4)
          : const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 6),
              blurRadius: 8,
            ),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Flow(
          delegate: ParallaxFlowDelegate(
            scrollable: Scrollable.of(context),
            listItemContext: context,
            backgroundImageKey: videoKey,
          ),
          children: [
            AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: VideoPlayer(
                videoPlayerController,
                key: videoKey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}