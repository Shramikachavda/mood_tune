// To parse this JSON data, do
//
//     final albumListResponse = albumListResponseFromJson(jsonString);

import 'dart:convert';

AlbumListResponse albumListResponseFromJson(String str) =>
    AlbumListResponse.fromJson(json.decode(str));

String albumListResponseToJson(AlbumListResponse data) =>
    json.encode(data.toJson());

class AlbumListResponse {
  Headers headers;
  List<Result> results;

  AlbumListResponse({required this.headers, required this.results});

  factory AlbumListResponse.fromJson(Map<String, dynamic> json) =>
      AlbumListResponse(
        headers: Headers.fromJson(json["headers"]),
        results: List<Result>.from(
          json["results"].map((x) => Result.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "headers": headers.toJson(),
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Headers {
  String status;
  int code;
  String errorMessage;
  String warnings;
  int resultsCount;
  String next;

  Headers({
    required this.status,
    required this.code,
    required this.errorMessage,
    required this.warnings,
    required this.resultsCount,
    required this.next,
  });

  factory Headers.fromJson(Map<String, dynamic> json) => Headers(
    status: json["status"],
    code: json["code"],
    errorMessage: json["error_message"],
    warnings: json["warnings"],
    resultsCount: json["results_count"],
    next: json["next"],
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

class Result {
  String id;
  String name;
  DateTime releasedate;
  String artistId;
  String artistName;
  String image;
  String zip;
  String shorturl;
  String shareurl;
  bool zipAllowed;

  Result({
    required this.id,
    required this.name,
    required this.releasedate,
    required this.artistId,
    required this.artistName,
    required this.image,
    required this.zip,
    required this.shorturl,
    required this.shareurl,
    required this.zipAllowed,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    releasedate: DateTime.parse(json["releasedate"]),
    artistId: json["artist_id"],
    artistName: json["artist_name"],
    image: json["image"],
    zip: json["zip"],
    shorturl: json["shorturl"],
    shareurl: json["shareurl"],
    zipAllowed: json["zip_allowed"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "releasedate":
        "${releasedate.year.toString().padLeft(4, '0')}-${releasedate.month.toString().padLeft(2, '0')}-${releasedate.day.toString().padLeft(2, '0')}",
    "artist_id": artistId,
    "artist_name": artistName,
    "image": image,
    "zip": zip,
    "shorturl": shorturl,
    "shareurl": shareurl,
    "zip_allowed": zipAllowed,
  };
}
