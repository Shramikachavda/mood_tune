import 'dart:convert';

// Entry point to parse JSON string
Music musicFromJson(String str) => Music.fromJson(json.decode(str));

// Convert Music object back to JSON string
String musicToJson(Music data) => json.encode(data.toJson());

class Music {
  Headers headers;
  List<ResponseResult> results;

  Music({required this.headers, required this.results});

  factory Music.fromJson(Map<String, dynamic> json) => Music(
    headers: Headers.fromJson(json["headers"]),
    results: List<ResponseResult>.from(
        json["results"].map((x) => ResponseResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "headers": headers.toJson(),
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Headers {
  String? status;
  int? code;
  String? errorMessage;
  String? warnings;
  int? resultsCount;
  String? next;

  Headers({
    this.status,
    this.code,
    this.errorMessage,
    this.warnings,
    this.resultsCount,
    this.next,
  });

  factory Headers.fromJson(Map<String, dynamic> json) => Headers(
    status: json["status"]?.toString(),
    code: json["code"] is int ? json["code"] : int.tryParse(json["code"]?.toString() ?? ''),
    errorMessage: json["error_message"]?.toString(),
    warnings: json["warnings"]?.toString(),
    resultsCount: json["results_count"] is int ? json["results_count"] : int.tryParse(json["results_count"]?.toString() ?? ''),
    next: json["next"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "error_message": errorMessage,
    "warnings": warnings,
    "results_count": resultsCount,
    "next": next,
  };
}

class ResponseResult {
  String? id;
  String? name;
  int? duration;
  String? artistId;
  String? artistName;
  String? artistIdstr;
  String? albumName;
  String? albumId;
  String? licenseCcurl;
  int? position;
  DateTime? releasedate;
  String? albumImage;
  String? audio;
  String? audiodownload;
  String? prourl;
  String? shorturl;
  String? shareurl;
  bool? audiodownloadAllowed;
  String? image;

  ResponseResult({
    this.id,
    this.name,
    this.duration,
    this.artistId,
    this.artistName,
    this.artistIdstr,
    this.albumName,
    this.albumId,
    this.licenseCcurl,
    this.position,
    this.releasedate,
    this.albumImage,
    this.audio,
    this.audiodownload,
    this.prourl,
    this.shorturl,
    this.shareurl,
    this.audiodownloadAllowed,
    this.image,
  });

  factory ResponseResult.fromJson(Map<String, dynamic> json) => ResponseResult(
    id: json["id"]?.toString(),
    name: json["name"]?.toString(),
    duration: json["duration"] is int ? json["duration"] : int.tryParse(json["duration"]?.toString() ?? ''),
    artistId: json["artist_id"]?.toString(),
    artistName: json["artist_name"]?.toString(),
    artistIdstr: json["artist_idstr"]?.toString(),
    albumName: json["album_name"]?.toString(),
    albumId: json["album_id"]?.toString(),
    licenseCcurl: json["license_ccurl"]?.toString(),
    position: json["position"] is int ? json["position"] : int.tryParse(json["position"]?.toString() ?? ''),
    releasedate: json["releasedate"] != null ? DateTime.tryParse(json["releasedate"]) : null,
    albumImage: json["album_image"]?.toString(),
    audio: json["audio"]?.toString(),
    audiodownload: json["audiodownload"]?.toString(),
    prourl: json["prourl"]?.toString(),
    shorturl: json["shorturl"]?.toString(),
    shareurl: json["shareurl"]?.toString(),
    audiodownloadAllowed: json["audiodownload_allowed"] is bool
        ? json["audiodownload_allowed"]
        : json["audiodownload_allowed"]?.toString().toLowerCase() == 'true',
    image: json["image"]?.toString(),
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "duration": duration,
    "artist_id": artistId,
    "artist_name": artistName,
    "artist_idstr": artistIdstr,
    "album_name": albumName,
    "album_id": albumId,
    "license_ccurl": licenseCcurl,
    "position": position,
    "releasedate": releasedate?.toIso8601String().split("T").first,
    "album_image": albumImage,
    "audio": audio,
    "audiodownload": audiodownload,
    "prourl": prourl,
    "shorturl": shorturl,
    "shareurl": shareurl,
    "audiodownload_allowed": audiodownloadAllowed,
    "image": image,
  };
}
