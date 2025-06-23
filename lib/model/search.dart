import 'dart:convert';

Search searchFromJson(String str) => Search.fromJson(json.decode(str));

String searchToJson(Search data) => json.encode(data.toJson());

class Search {
  Headers headers;
  Results results;

  Search({required this.headers, required this.results});

  factory Search.fromJson(Map<String, dynamic> json) => Search(
    headers: Headers.fromJson(json["headers"]),
    results: Results.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "headers": headers.toJson(),
    "results": results.toJson(),
  };
}

class Headers {
  String status;
  int code;
  String errorMessage;
  String warnings;
  int resultsCount;

  Headers({
    required this.status,
    required this.code,
    required this.errorMessage,
    required this.warnings,
    required this.resultsCount,
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

class Results {
  List<String> tags;
  List<String> artists;
  List<String> tracks;
  List<String> albums;

  Results({
    required this.tags,
    required this.artists,
    required this.tracks,
    required this.albums,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    tags: List<String>.from(json["tags"]),
    artists: List<String>.from(json["artists"]),
    tracks: List<String>.from(json["tracks"]),
    albums: List<String>.from(json["albums"]),
  );

  Map<String, dynamic> toJson() => {
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "artists": List<dynamic>.from(artists.map((x) => x)),
    "tracks": List<dynamic>.from(tracks.map((x) => x)),
    "albums": List<dynamic>.from(albums.map((x) => x)),
  };
}
