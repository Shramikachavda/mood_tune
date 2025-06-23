import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_tune/model/music_info.dart';
import 'package:mood_tune/repo/i_music_repository.dart';
import '../../model/album_list_response.dart';
import '../../model/artist_with_album.dart';
import '../../model/music_api_response.dart';

class HomeController extends GetxController {
  final IMusicRepo musicRepo = Get.find<IMusicRepo>();

  //fetch music
  var music = Rxn<Music>();
  var result = <ResponseResult>[].obs;
  var artistBaseMusic = <ResponseResult>[].obs;
  final isLoading = false.obs;
  int offset = 0;
  final int limit = 30;
  final hasMore = true.obs;
  final Set<String> _addedArtists = {};
  final String tags ="";

  // Artist Data via Album
  var artistAlbums = <Result>[].obs;
  final Set<String> _addArtist = {};
  var artistNextUrl = RxnString();
  final isLoadingArtist = false.obs;

  //artist (uniq)
  final isLoadingArtistAlbum = false.obs;
  var artistData = Rxn<ArtistWithAlbums>();

  //music info
  final isMusicInfoLoading = false.obs;
 var musicInfoForArtistDetail = Rxn<MusicInfo>();
  var MusicDataNextUrl = RxnString();

  //controllers
  final ScrollController musicScrollController = ScrollController();
  final ScrollController artistScrollController = ScrollController();
  final ScrollController musicInfoController = ScrollController();

  @override
  void onInit() {
 //  fetchUniqueArtists();
   // fetchMusic();

    //no need to use for now
   //  fetchArtistsFromAlbums(url: artistNextUrl.value);


   // fetchMusicInfo();

    //cam=n be use
  //   fetchUniqueArtists();
    super.onInit();

    musicInfoController.addListener(() {
      print("scroll controller calling");
      if (musicInfoController.position.pixels >=
              musicInfoController.position.maxScrollExtent - 200 &&
          MusicDataNextUrl.value !=null &&
          !isMusicInfoLoading.value) {
        fetchMusicInfo(url: MusicDataNextUrl.value);
      }
    });

    artistScrollController.addListener(() {
      if (artistScrollController.position.pixels >=
              artistScrollController.position.maxScrollExtent - 200 &&
          artistNextUrl.value != null &&
          !isLoadingArtist.value) {
        fetchArtistsFromAlbums(url: artistNextUrl.value);
      }
    });
  }



  //used
  void fetchArtistsFromAlbums({String? url}) async {
    isLoadingArtist.value = true;

    try {
      final response = await musicRepo.fetchAlbums(
        url: url,
        limit: 30,
        offset: artistAlbums.length,
      );

      for (var album in response.results) {
        if (!_addArtist.contains(album.artistName)) {
          artistAlbums.add(album);
          _addArtist.add(album.artistName);
        }
      }

      artistNextUrl.value = response.headers.next;
    } catch (e) {
      print("Error fetching artists from albums: $e");
    } finally {
      isLoadingArtist.value = false;
    }
  }


  void fetchMusic() async {
    isLoading.value = true;
    try {
      final musicResponse = await musicRepo.fetchMusic(
          limit: limit,
          offSet: offset,

      );

      music.value = musicResponse;
      // result.addAll(musicResponse.results);

      /*  final artist  = RxList<Result>(
        musicResponse.results
            .where(
              (e) => e.artistName == musicResponse.results.first.artistName,
            )
            .toList(),
      );*/

      for (var item in musicResponse.results) {
        print("artist");
        print(item.artistName);

        if (!_addedArtists.contains(item.artistName)) {
          artistBaseMusic.add(item);
          _addedArtists.add(item.artistName ?? '');
        }
      }
      result.addAll(musicResponse.results);

      offset += limit; // move to next page

      if (musicResponse.results.length < limit) {
        hasMore.value = false;
      }
    } catch (e) {
      print("Error fetching music: $e");
    } finally {
      isLoading.value = false;
    }
  }

  //if i want to show artist name and there list of album then i can use and i
  // can give me link of the  playlist from jamendo app
  Future<void> fetchUniqueArtists() async {
    try {
      isLoadingArtistAlbum.value = true;

      final response = await musicRepo.fetchUniqueArtists();

      artistData.value = response;
    } catch (e) {
      print("Error fetching artists from albums: $e");
    } finally {
      isLoadingArtistAlbum.value = false;
    }
  }

  //used to show artist in home screen
  Future<void> fetchMusicInfo({String? url}) async {
    try {
      isMusicInfoLoading.value = true;
      final data = await musicRepo.fetchMusicInfo(url: url);

      // First load
      if (musicInfoForArtistDetail.value == null || url == null) {
        musicInfoForArtistDetail.value = data;
      } else {
        // Append paginated results
        musicInfoForArtistDetail.update((existing) {
          existing?.results.addAll(data.results);
        });
      }
    //  musicInfoForArtistDetail.value = data;
      isMusicInfoLoading.value = false;

      MusicDataNextUrl.value = data.headers.next;
    } catch (e) {
      isMusicInfoLoading.value = false;
      print("something went wrong $e");
    }
  }
}
