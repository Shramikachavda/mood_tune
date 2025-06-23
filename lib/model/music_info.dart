// To parse this JSON data, do
//
//     final musicInfo = musicInfoFromJson(jsonString);

//music info : electronica , neoclassical , classical , piano

import 'dart:convert';

MusicInfo musicInfoFromJson(String str) => MusicInfo.fromJson(json.decode(str));

String musicInfoToJson(MusicInfo data) => json.encode(data.toJson());

class MusicInfo {
  Headers headers;
  List<MusicInfoResult> results;

  MusicInfo({required this.headers, required this.results});

  factory MusicInfo.fromJson(Map<String, dynamic> json) => MusicInfo(
    headers: Headers.fromJson(json["headers"]),
    results: List<MusicInfoResult>.from(
      json["results"].map((x) => MusicInfoResult.fromJson(x)),
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

class MusicInfoResult {
  String id;
  String name;
  String website;
  DateTime joindate;
  String image;
  String shorturl;
  String shareurl;
  Musicinfo musicinfo;

  MusicInfoResult({
    required this.id,
    required this.name,
    required this.website,
    required this.joindate,
    required this.image,
    required this.shorturl,
    required this.shareurl,
    required this.musicinfo,
  });

  factory MusicInfoResult.fromJson(Map<String, dynamic> json) =>
      MusicInfoResult(
        id: json["id"],
        name: json["name"],
        website: json["website"],
        joindate: DateTime.parse(json["joindate"]),
        image: json["image"],
        shorturl: json["shorturl"],
        shareurl: json["shareurl"],
        musicinfo: Musicinfo.fromJson(json["musicinfo"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "website": website,
    "joindate":
        "${joindate.year.toString().padLeft(4, '0')}-${joindate.month.toString().padLeft(2, '0')}-${joindate.day.toString().padLeft(2, '0')}",
    "image": image,
    "shorturl": shorturl,
    "shareurl": shareurl,
    "musicinfo": musicinfo.toJson(),
  };
}

class Musicinfo {
  List<String> tags;
  Description description;

  Musicinfo({required this.tags, required this.description});

  factory Musicinfo.fromJson(Map<String, dynamic> json) => Musicinfo(
    tags: List<String>.from(json["tags"].map((x) => x)),
    description: Description.fromJson(json["description"]),
  );

  Map<String, dynamic> toJson() => {
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "description": description.toJson(),
  };
}

class Description {
  String en;
  String fr;
  String es;
  String de;
  String pl;
  String it;
  String ru;
  String pt;
  String ja;

  Description({
    required this.en,
    required this.fr,
    required this.es,
    required this.de,
    required this.pl,
    required this.it,
    required this.ru,
    required this.pt,
    required this.ja,
  });

  factory Description.fromJson(Map<String, dynamic> json) => Description(
    en: json["en"],
    fr: json["fr"],
    es: json["es"],
    de: json["de"],
    pl: json["pl"],
    it: json["it"],
    ru: json["ru"],
    pt: json["pt"],
    ja: json["ja"],
  );

  Map<String, dynamic> toJson() => {
    "en": en,
    "fr": fr,
    "es": es,
    "de": de,
    "pl": pl,
    "it": it,
    "ru": ru,
    "pt": pt,
    "ja": ja,
  };
}
