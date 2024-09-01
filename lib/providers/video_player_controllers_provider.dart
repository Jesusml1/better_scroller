import 'package:better_scroller/notifiers/video_player_controller_notifier.dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

final videoPlayerControllersProvider = NotifierProvider.autoDispose<
    VideoPlayerControllerNotifier, Map<int, VideoPlayerController>>(
  VideoPlayerControllerNotifier.new,
);
