// To parse this JSON data, do
//
//     final artistWithAlbums = artistWithAlbumsFromJson(jsonString);

import 'dart:convert';

ArtistWithAlbums artistWithAlbumsFromJson(String str) =>
    ArtistWithAlbums.fromJson(json.decode(str));

String artistWithAlbumsToJson(ArtistWithAlbums data) =>
    json.encode(data.toJson());

class ArtistWithAlbums {
  Headers headers;
  List<ArtistWithAlbumsResult> results;

  ArtistWithAlbums({required this.headers, required this.results});

  factory ArtistWithAlbums.fromJson(Map<String, dynamic> json) =>
      ArtistWithAlbums(
        headers: Headers.fromJson(json["headers"]),
        results: List<ArtistWithAlbumsResult>.from(
          json["results"].map((x) => ArtistWithAlbumsResult.fromJson(x)),
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

class ArtistWithAlbumsResult {
  String id;
  String name;
  String website;
  DateTime joindate;
  String image;
  List<Album> albums;

  ArtistWithAlbumsResult({
    required this.id,
    required this.name,
    required this.website,
    required this.joindate,
    required this.image,
    required this.albums,
  });

  factory ArtistWithAlbumsResult.fromJson(Map<String, dynamic> json) =>
      ArtistWithAlbumsResult(
        id: json["id"],
        name: json["name"],
        website: json["website"],
        joindate: DateTime.parse(json["joindate"]),
        image: json["image"],
        albums: List<Album>.from(json["albums"].map((x) => Album.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "website": website,
    "joindate":
        "${joindate.year.toString().padLeft(4, '0')}-${joindate.month.toString().padLeft(2, '0')}-${joindate.day.toString().padLeft(2, '0')}",
    "image": image,
    "albums": List<dynamic>.from(albums.map((x) => x.toJson())),
  };
}

class Album {
  String id;
  String name;
  DateTime releasedate;
  String image;

  Album({
    required this.id,
    required this.name,
    required this.releasedate,
    required this.image,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    id: json["id"],
    name: json["name"],
    releasedate: DateTime.parse(json["releasedate"]),
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "releasedate":
        "${releasedate.year.toString().padLeft(4, '0')}-${releasedate.month.toString().padLeft(2, '0')}-${releasedate.day.toString().padLeft(2, '0')}",
    "image": image,
  };
}
