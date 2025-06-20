import 'dart:convert';

VideoModel videoModelFromJson(String str) => VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  String? title;
  String? thumbnailUrl;
  String? vimeoId;

  VideoModel({
    this.title,
    this.thumbnailUrl,
    this.vimeoId,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    title: json["title"],
    thumbnailUrl: json["thumbnail"],
    vimeoId: json["vimeoId"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "thumbnail": thumbnailUrl,
    "vimeoId": vimeoId,
  };
}
