import 'dart:convert';
import 'package:better_scroller/models/video/video.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final videosProvider = FutureProvider.autoDispose<List<Video>>((ref) async {
  try {
    final String response = await rootBundle.loadString('assets/videos.json');
    final data = await json.decode(response) as List<dynamic>;
    final videos = data.map((e) => Video.fromJson(e)).toList();

    return videos;
  } catch (e) {
    // print(e);
    return [];
  }
});
