import 'package:better_scroller/providers/videos_providers.dart';
import 'package:better_scroller/views/video_scroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videos = ref.watch(videosProvider);

    return Scaffold(
      // appBar: AppBar(title: const Text('Better scroller')),
      body: videos.when(
        data: (data) {
          return VideoScroller(videoList: data);
        },
        loading: () => Container(),
        error: (error, stackTrace) => const Center(
          child: Text("Error fetching videos"),
        ),
      ),
    );
  }
}
