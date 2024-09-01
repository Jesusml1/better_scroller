import 'package:better_scroller/models/video/video.dart';
import 'package:better_scroller/providers/video_player_controllers_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends ConsumerStatefulWidget {
  final Video video;
  final int index;

  const VideoPlayerWidget({
    super.key,
    required this.video,
    required this.index,
  });

  @override
  ConsumerState<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends ConsumerState<VideoPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controllers = ref.watch(videoPlayerControllersProvider);
    final videoPlayerController = controllers[widget.index];

    if (videoPlayerController == null ||
        !videoPlayerController.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SizedBox(
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
        VideoPlayer(videoPlayerController),
        Positioned(
          bottom: 10,
          width: size.width - 10,
          child: SizedBox(
            child: VideoProgressIndicator(
              videoPlayerController,
              allowScrubbing: true,
              colors: const VideoProgressColors(
                backgroundColor: Colors.white24,
                playedColor: Colors.white60,
              ),
            ),
          ),
        ),
        // videoPlayerController.value.isBuffering ?
        // const Positioned(child: CircularProgressIndicator())
        // : Container()
      ]),
    );
  }
}
