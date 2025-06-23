import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../model/album_song_by_artist.dart';
import '../../reusable/img.dart';
import '../../util/extention/data_time_formatter.dart';
import '../../util/extention/min_to_second_convertor.dart';
import 'album_page_controller.dart';

class AlbumPageUi extends StatelessWidget {
  AlbumPageUi({super.key});

  static const String routeName = '/AlbumPageUi';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => AlbumPageUi(),
    );
  }

  final AlbumPageController controller = Get.find<AlbumPageController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar:
            controller.showAppBar.value
                ? AppBar(
                  automaticallyImplyLeading: false,
                  title: Text(
                    controller.name,
                    style: TextStyle(color: Color(0xccCABBEf)),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                )
                : null,
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (controller.isLoading.value) {
      return Center(child: CircularProgressIndicator());
    }

    final albumData = controller.albums.value;
    if (albumData == null || albumData.results?.isEmpty == true) {
      return Center(child: Text("No albums found"));
    }

    final album = albumData.results!.first;

    return SingleChildScrollView(
      controller: controller.controller,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Opacity(
                opacity: 0.5,
                child: image(
                  img: album.image ?? "a",
                  width: double.infinity,
                  height: 350.h,
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Text(
                  album.name ?? "",
                  style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                bottom: 5,
                left: 20,
                child: Text(formatDate(album.joindate)),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Tracks",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xffCABBEf),
                // color: Theme.of(context).primaryColor.withValues(alpha: 0.8),
              ),
            ),
          ),
          listOfTracks(album.tracks),
        ],
      ),
    );
  }

  Widget listOfTracks(List<Track>? tracks) {
    if (tracks == null || tracks.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(20),
        child: Text("No tracks found"),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        final track = tracks[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${index + 1}"),
              SizedBox(width: 5,) ,
              image(img: track.albumImage ?? "", height: 60.h, width: 60.h),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      track.name ?? "Unknown Track",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(formatDuration(track.duration)),
                  ],
                ),
              ),
              Obx(() {
                final isCurrent =
                    controller.currentTrackUrl.value == track.audio;
                return IconButton(
                  icon: Icon(isCurrent ? Icons.stop : Icons.play_arrow),
                  onPressed: () {
                    if (isCurrent) {
                      controller.stopMusic();
                    } else {
                      controller.playMusic(track.audio ?? "");
                    }
                  },
                );
              }),
              IconButton(
                icon: Icon(Icons.download),
                onPressed: () {
                  controller.downloadMusicOffline(
                    track.audiodownload ?? "",
                    track.name ?? "track",
                  );


                },
              ),
            ],
          ),
        );
      },
    );
  }
}
