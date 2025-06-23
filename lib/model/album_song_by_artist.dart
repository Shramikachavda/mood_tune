// To parse this JSON data, do
//
//     final songFetchByArtistName = songFetchByArtistNameFromJson(jsonString);

import 'dart:convert';

SongFetchByArtistName songFetchByArtistNameFromJson(String str) =>
    SongFetchByArtistName.fromJson(json.decode(str));

String songFetchByArtistNameToJson(SongFetchByArtistName data) =>
    json.encode(data.toJson());

class SongFetchByArtistName {
  Headers? headers;
  List<Result>? results;

  SongFetchByArtistName({this.headers, this.results});

  factory SongFetchByArtistName.fromJson(Map<String, dynamic> json) =>
      SongFetchByArtistName(
        headers:
            json["headers"] == null ? null : Headers.fromJson(json["headers"]),
        results:
            json["results"] == null
                ? []
                : List<Result>.from(
                  json["results"]!.map((x) => Result.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "headers": headers?.toJson(),
    "results":
        results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Headers {
  String? status;
  int? code;
  String? errorMessage;
  String? warnings;
  int? resultsCount;

  Headers({
    this.status,
    this.code,
    this.errorMessage,
    this.warnings,
    this.resultsCount,
  });

  factory Headers.fromJson(Map<String, dynamic> json) => Headers(
    status: json["status"],
    code: json["code"],
    errorMessage: json["error_message"],
    warnings: json["warnings"],
    resultsCount: json["results_count"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "error_message": errorMessage,
    "warnings": warnings,
    "results_count": resultsCount,
  };
}

class Result {
  String? id;
  String? name;
  String? website;
  DateTime? joindate;
  String? image;
  List<Track>? tracks;

  Result({
    this.id,
    this.name,
    this.website,
    this.joindate,
    this.image,
    this.tracks,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    website: json["website"],
    joindate:
        json["joindate"] == null ? null : DateTime.parse(json["joindate"]),
    image: json["image"],
    tracks:
        json["tracks"] == null
            ? []
            : List<Track>.from(json["tracks"]!.map((x) => Track.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "website": website,
    "joindate":
        "${joindate!.year.toString().padLeft(4, '0')}-${joindate!.month.toString().padLeft(2, '0')}-${joindate!.day.toString().padLeft(2, '0')}",
    "image": image,
    "tracks":
        tracks == null
            ? []
            : List<dynamic>.from(tracks!.map((x) => x.toJson())),
  };
}

class Track {
  String? albumId;
  String? albumName;
  String? id;
  String? name;
  String? duration;
  DateTime? releasedate;
  String? licenseCcurl;
  String? albumImage;
  String? image;
  String? audiodownload;
  bool? audiodownloadAllowed;
  String? audio;

  Track({
    this.albumId,
    this.albumName,
    this.id,
    this.name,
    this.duration,
    this.releasedate,
    this.licenseCcurl,
    this.albumImage,
    this.image,
    this.audiodownload,
    this.audiodownloadAllowed,
    this.audio,
  });

  factory Track.fromJson(Map<String, dynamic> json) => Track(
    albumId: json["album_id"],
    albumName: json["album_name"],
    id: json["id"],
    name: json["name"],
    duration: json["duration"],
    releasedate:
        json["releasedate"] == null
            ? null
            : DateTime.parse(json["releasedate"]),
    licenseCcurl: json["license_ccurl"],
    albumImage: json["album_image"],
    image: json["image"],
    audiodownload: json["audiodownload"],
    audiodownloadAllowed: json["audiodownload_allowed"],
    audio: json["audio"],
  );

  Map<String, dynamic> toJson() => {
    "album_id": albumId,
    "album_name": albumName,
    "id": id,
    "name": name,
    "duration": duration,
    "releasedate":
        "${releasedate!.year.toString().padLeft(4, '0')}-${releasedate!.month.toString().padLeft(2, '0')}-${releasedate!.day.toString().padLeft(2, '0')}",
    "license_ccurl": licenseCcurl,
    "album_image": albumImage,
    "image": image,
    "audiodownload": audiodownload,
    "audiodownload_allowed": audiodownloadAllowed,
    "audio": audio,
  };
}
