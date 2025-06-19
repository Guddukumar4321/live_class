import 'dart:convert';

VideoModel videoModelFromJson(String str) => VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  String? title;
  String? thumbnailUrl;
  String? videoUrl;

  VideoModel({
    this.title,
    this.thumbnailUrl,
    this.videoUrl,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    title: json["title"],
    thumbnailUrl: json["thumbnailUrl"],
    videoUrl: json["videoUrl"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "thumbnailUrl": thumbnailUrl,
    "videoUrl": videoUrl,
  };
}
