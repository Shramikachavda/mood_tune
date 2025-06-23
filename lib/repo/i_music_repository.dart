import '../model/album_list_response.dart';
import '../model/album_song_by_artist.dart';
import '../model/artist_with_album.dart';
import '../model/music_api_response.dart';
import '../model/music_info.dart';
import '../model/search.dart';

abstract class IMusicRepo {
  //user in detail page (navigate to home page via fetch album artist and in search page)
  Future<SongFetchByArtistName> fetchTracksByArtistName({
  String? albumName,
  String? name,
});

  //used in search page for get the result (result is in form of string
  //contain artist ,  tag , album , track
  Future<Search> searchArtist(String query);

  //used for show artist name and image in home page
  Future<MusicInfo> fetchMusicInfo({String? url, int? limit, int? offSet});


//  used in  detail page   (navigate from seach screen  based on tags and  track name )
  Future<Music> fetchMusic({
    required int limit,
    required int offSet,
    String? fuzzytags,
    String? namesearch,
  });

  //if i want to show artist name and there list of album then i can use and i
  // can give me link of the  playlist from jamendo app
  Future<ArtistWithAlbums> fetchUniqueArtists();



  //if i want to give them download zip file  then i an use but for now i do not need to use
  Future<AlbumListResponse> fetchAlbums({
    String? url,
    int limit = 20,
    int offset = 0,
  });
}
