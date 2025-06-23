import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mood_tune/presentation/search/search_controller.dart';
import '../../generated/assets.dart';
import '../../model/search.dart';
import '../album_page_detail/album_page_ui.dart';
import '../detail_fetch_music/detail_fetch_music_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  static const String routeName = '/SearchScreen';

  //route for navigation
  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => SearchScreen(),
    );
  }

  //text editing controller for search field
  final TextEditingController _searchController = TextEditingController();

  //focus node for search field
  final FocusNode _focusNode = FocusNode();

  //controller form the get x
  final controller = Get.find<SearchControllerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10.h),
              TextFormField(
                controller: _searchController,
                focusNode: _focusNode,
                onChanged: (value) => controller.searchText.value = value,
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Tracks, artists, albums, moods",
                  suffixIcon: IconButton(
                    onPressed: () {
                      _searchController.clear();
                      controller.searchText.value = '';
                    },
                    icon: Icon(Icons.cancel_outlined),
                  ),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(0.h),
                  ),
                ),
              ),

              Expanded(
                child: Obx(() {
                  final data = controller.searchData.value;

                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (controller.error.value != null) {
                    return Center(
                      child: Text(
                        controller.error.value!,
                        style: TextStyle(
                          color: Color(0xffcabbef),
                          fontSize: 16.sp,
                        ),
                      ),
                    );
                  }

                  if (controller.searchText.isEmpty == true) {
                    return Center(
                      child: Text(
                        "Find music by track, artist, album or mood",
                        style: TextStyle(
                          color: Color(0xffcabbef),
                          fontSize: 16.sp,
                        ),
                      ),
                    );
                  }

                  if (data == null ||
                      (data.results.albums.isEmpty &&
                          data.results.tracks.isEmpty &&
                          data.results.artists.isEmpty &&
                          data.results.tags.isEmpty)) {
                    return Center(
                      child: Text(
                        "No results found",
                        style: TextStyle(
                          color: Color(0xffcabbef),
                          fontSize: 16.sp,
                        ),
                      ),
                    );
                  }

                  return SingleChildScrollView(child: listOfAllData(data));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //list of all data with name and list of that data item
  Widget listOfAllData(Search data) {
    final artists = data.results.artists;
    final albums = data.results.albums;
    final tags = data.results.tags;
    final tracks = data.results.tracks;

    return Column(
      children: [
        SizedBox(height: 20.h),
        if (artists.isNotEmpty)
          Column(
            children: [
              typeOfSearchResult("Artists"),
              listOfSearchResult(
                itemBuilder:
                    (artist) => ListTile(
                      title: Text(artist),
                      leading: Image.asset(
                        Assets.imgArtist,
                        color: Color(0xcccabbef),
                        height: 24.h,
                        width: 24.h,
                      ),
                      onTap:
                          () => Get.to(
                            () => AlbumPageUi(),
                            arguments: {'type': 'artist', 'value': artist},
                          ),
                    ),
                data: artists,
              ),
            ],
          ),

        if (albums.isNotEmpty)
          Column(
            children: [
              typeOfSearchResult("Albums"),

              listOfSearchResult(
                itemBuilder: (album) {
                  return ListTile(
                    title: Text(album),
                    leading: Image.asset(
                      Assets.imgAlbum,
                      color: Color(0xcccabbef),
                      height: 20.h,
                      width: 20.h,
                    ),
                    onTap:
                        () => Get.to(
                          () => AlbumPageUi(),
                          arguments: {'type': 'albums', 'value': album},
                        ),
                  );
                },
                data: albums,
              ),
            ],
          ),

        if (tags.isNotEmpty)
          Column(
            children: [
              typeOfSearchResult("Tags"),
              listOfSearchResult(
                itemBuilder: (tags) {
                  return ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.hashtag,
                      size: 18.sp,
                      color: Color(0xcccabbef).withValues(alpha: 0.6),
                    ),
                    title: Text(tags),
                    onTap:
                        () => Get.to(
                          () => DetailFetchMusicUi(),
                          arguments: {'type': 'tag', 'value': tags},
                        ),
                  );
                },
                data: tags,
              ),
            ],
          ),

        if (tracks.isNotEmpty)
          Column(
            children: [
              typeOfSearchResult("Tracks"),

              listOfSearchResult(
                itemBuilder: (tracks) {
                  return ListTile(
                    leading: Image.asset(
                      Assets.imgMus,
                      color: Color(0xcccabbef),
                      height: 20.h,
                      width: 20.h,
                    ),
                    title: Text(tracks),
                    onTap:
                        () => Get.to(
                          () => DetailFetchMusicUi(),
                          arguments: {'type': 'track', 'value': tracks},
                        ),
                  );
                },
                data: tracks,
              ),
            ],
          ),
      ],
    );
  }

  //name of search type (artist , album , tag , track)
  Widget typeOfSearchResult(String type) {
    return Column(
      children: [
        const Divider(height: 1, thickness: 1),
        Container(
          margin: EdgeInsets.zero,
          height: 50.h,
          width: double.infinity,
          color: Colors.white12,
          child: Center(
            child: Text(
              type,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xffcabbef),
              ),
            ),
          ),
        ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }

  //list of String  based on search
  Widget listOfSearchResult({
    required Widget Function(String value) itemBuilder,
    required List<String> data,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return itemBuilder(data[index]);
      },
    );
  }
}
