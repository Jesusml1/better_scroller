import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@freezed
class Video with _$Video {
  const factory Video({
    required String id,
    required String url,
  }) = _Video;

  factory Video.fromJson(Map<String, Object?> json) => _$VideoFromJson(json);
}
