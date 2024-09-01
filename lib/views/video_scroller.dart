import 'package:better_scroller/models/video/video.dart';
import 'package:better_scroller/providers/video_player_controllers_provider.dart';
import 'package:better_scroller/views/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoScroller extends HookConsumerWidget {
  final List<Video> videoList;
  const VideoScroller({
    super.key,
    required this.videoList,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPageIndex = useState(0);

    useEffect(() {
      ref
          .read(videoPlayerControllersProvider.notifier)
          .initializeControllers(currentPageIndex.value, videoList);

      return null;
    }, [currentPageIndex.value]);

    void onPageChange(int newIndex) {
      final videoPlayerControllersNotifier =
          ref.read(videoPlayerControllersProvider.notifier);
      videoPlayerControllersNotifier.pauseVideo(currentPageIndex.value);
      videoPlayerControllersNotifier.resetVideo(currentPageIndex.value);

      currentPageIndex.value = newIndex;
      Future.delayed(const Duration(milliseconds: 500), () {
        videoPlayerControllersNotifier.playVideo(currentPageIndex.value);
      });
    }

    return PageView.builder(
      itemCount: videoList.length,
      scrollDirection: Axis.vertical,
      onPageChanged: (newIndex) => onPageChange(newIndex),
      itemBuilder: (context, index) {
        return VideoPlayerWidget(
          video: videoList[index],
          index: index,
        );
      },
    );
  }
}
