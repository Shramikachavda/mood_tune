import 'dart:convert';
import 'package:mood_tune/repo/i_music_repository.dart';
import '../core/api/api_constant.dart';
import '../core/api/i_Api_service.dart';
import '../model/album_list_response.dart';
import '../model/album_song_by_artist.dart';
import '../model/artist_with_album.dart';
import '../model/music_api_response.dart';
import '../model/music_info.dart';
import '../model/search.dart';

class MusicRepo implements IMusicRepo {
  final IApiService api;

  MusicRepo(this.api);

  // can be used
  @override
  Future<Music> fetchMusic({
    required int limit,
    required int offSet,
    String? fuzzytags,
    String? namesearch,
  }) async {
    final response = await api.get(
      ApiConstant.endpoint,
      queryParameters: {
        'client_id': '0f589380',
        'format': 'json',
        'limit': limit,
        'offset': offSet,
        'fuzzytags': fuzzytags,
       "namesearch": namesearch,
      },
    );

    print("response from repo $response");
    print(response.runtimeType);

    final music = musicFromJson(jsonEncode(response));

    print(music.runtimeType);
    return music;
  }

  //song fetch by artist name   (can be used) based on artist
  @override
  Future<SongFetchByArtistName> fetchTracksByArtistName({
    String? albumName,
    String? name,
  }) async {
    final response = await api.get(
      'artists/tracks',
      queryParameters: {
        'client_id': '0f589380',
        'name': name,
        'format': 'json',
        'album_name': albumName,
      },
    );
    print("Raw API Response in repo : $response");

    final musicByArtist = songFetchByArtistNameFromJson(jsonEncode(response));
    print("musicByArtist");
    print(musicByArtist);
    return musicByArtist;
  }

  //can be use to show img in ui based on that cn navigate to new pagw and play
  // album  by fetch track by id  (no music)
  //artist by album
  @override
  Future<ArtistWithAlbums> fetchUniqueArtists() async {
    final response = await api.get(
      "artists/albums",
      queryParameters: {'client_id': '0f589380', 'format': 'json'},
    );

    final music = artistWithAlbumsFromJson(jsonEncode(response));
    return music;
  }

  //search
  @override
  Future<Search> searchArtist(String query) async {
    final response = await api.get(
      'autocomplete',
      queryParameters: {'client_id': '0f589380', 'prefix': query},
    );

    final search = searchFromJson(jsonEncode(response));

    return search;
  }

  //zip file for download album  based on arstist and can share album
  @override
  Future<AlbumListResponse> fetchAlbums({
    String? url,
    int limit = 20,
    int offset = 0,
  }) async {
    if (url != null && url.isNotEmpty) {
      // Use the full next URL directly
      final response = await api.get(url);
      final music = albumListResponseFromJson(jsonEncode(response));
      return music;
    } else {
      // Use base endpoint with params
      final res = await api.get(
        'albums',
        queryParameters: {
          'client_id': '0f589380',
          'limit': limit,
          'offset': offset,
        },
      );

      // Convert response.data to JSON string for your parser
      final music = albumListResponseFromJson(jsonEncode(res));
      return music;
    }
  }

  //music info
  @override
  Future<MusicInfo> fetchMusicInfo({
    String? url,
    int? limit,
    int? offSet,
  }) async {
    if (url != null && url.isNotEmpty) {
      final response = await api.get(url);
      final music = musicInfoFromJson(jsonEncode(response));
      return music;
    }
    final response = await api.get(
      "artists/musicinfo/",
      queryParameters: {'client_id': '0f589380', 'format': 'json'},
    );

    final musicByArtist = musicInfoFromJson(jsonEncode(response));
    return musicByArtist;
  }
}
