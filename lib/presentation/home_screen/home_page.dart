import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mood_tune/model/artist_with_album.dart';
import '../../reusable/img.dart';
import '../album_page_detail/album_page_ui.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  static const String routeName = '/HomePage';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => HomePage(),
    );
  }

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Obx(() {
        if (controller.isLoading.value && controller.result.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        /*if (controller.result.isEmpty) {
          return Center(child: Text("No Music found"));
        }*/

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Artist",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Color(0xffcabbef),
                  ),
                ),
                Text(
                  "Discover your favorite voice",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Color(0xcccabbef),
                  ),
                ),
                SizedBox(height: 20.h),
                //musicBasedOnArtist(),
                fetchMusicInfo(),
                Text(
                  "Your daily dose of music",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xcccabbef),
                  ),
                ),
                // Expanded(child: fetchMusicInfo()),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget musicBasedOnArtist() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: controller.artistBaseMusic.length,
        itemBuilder: (context, index) {
          final musicBasedOnArtist = controller.artistBaseMusic[index];
          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 0.w : 20.w),
            child: Container(
              padding: EdgeInsets.all(4.h),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffcabbef), width: 0.3),
              ),
              width: 100,
              child: ListTile(
                title: image(
                  img: musicBasedOnArtist.image ?? "",
                  height: 70.h,
                  width: 70.h,
                ),
                subtitle: Text(
                  musicBasedOnArtist.artistName ?? "",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget musicGridView() {
    return GridView.builder(
      controller: controller.musicScrollController,
      shrinkWrap: true,
      itemCount: controller.result.length + (controller.hasMore.value ? 1 : 0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        if (index < controller.result.length) {
          final song = controller.result[index];
          return Column(
            children: [
              image(img: song.image ?? "", height: 100.h, width: 100.w),
              Text(song.name ?? ""),
              Text(song.albumName ?? ""),
            ],
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  //artist
  Widget fetchMusic() {
    return ListView.builder(
      controller: controller.artistScrollController,
      shrinkWrap: true,
      itemCount:
          controller.artistAlbums.length +
          ((controller.artistNextUrl.value != null) ? 1 : 0),

      itemBuilder: (context, index) {
        if (index < (controller.artistAlbums.length)) {
          final song = controller.artistAlbums[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Row(
              spacing: 20,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40.r),

                  child: image(img: song.image, height: 80.h, width: 80.w),
                ),
                Text(song.artistName),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget fetchMusicInfo() {
    return SizedBox(
      height: 150.h,
      child: ListView.builder(
        controller: controller.musicInfoController,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,

        itemCount:
            (controller.musicInfoForArtistDetail.value?.results.length ?? 0) +
            ((controller.MusicDataNextUrl.value != null) ? 1 : 0),

        itemBuilder: (context, index) {
          if (index <
              (controller.musicInfoForArtistDetail.value?.results.length ??
                  0)) {
            final song =
                controller.musicInfoForArtistDetail.value?.results[index];
            return song == null
                ? Text("No artist found")
                : Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 0.w : 20.w),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => AlbumPageUi(),      arguments: {'type': 'tag', 'value': song});
                    },

                    child: Column(
                      spacing: 20,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40.r),
                          child: imgAvatar(img: song.image),
                        ),
                        Text(song.name),
                      ],
                    ),
                  ),
                );
          } else {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              height: 80.h,
              width: 80.w,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }

  Widget art() {
    return ListView.builder(
      itemCount: controller.artistData.value?.results.length ?? 0,
      itemBuilder: (context, index) {
        final album = controller.artistData.value?.results[index];

        return Column(
          children: [
            Text(album?.name ?? "a"),
            Text(album?.id ?? "a"),
            image(img: album?.image ?? "a"),

            listOfAlbum(album?.albums),
          ],
        );
      },
    );
  }

  Widget listOfAlbum(List<Album>? albums) {
    if (albums == null || albums.isEmpty) {
      return Center(child: Text("No Album "));
    }
    return SizedBox(
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: albums.length,
        itemBuilder: (context, index) {
          final album = albums[index];
          return Column(children: [Text(album.name), image(img: album.image)]);
        },
      ),
    );
  }
}
