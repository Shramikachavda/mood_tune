import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'detail_fetch_music_controller.dart';

class DetailFetchMusicUi extends StatelessWidget {
  DetailFetchMusicUi({super.key});

  static const String routeName = '/DetailFetchMusicUi';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => DetailFetchMusicUi(),
    );
  }

  final DetailFetchMusicController controller =
      Get.find<DetailFetchMusicController>();

  @override
  Widget build(BuildContext context) {
   // controller.clearPrevious();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Obx(() {
          if (controller.isLoadingMusic.value && controller.result.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.result.isEmpty) {
            return Center(
              child: Text(
                "No songs found",
                style: TextStyle(color: Color(0xffcabbef), fontSize: 16.sp),
              ),
            );
          }

          return ListView.builder(
            controller: controller.musicScrollController,
            itemCount:
                controller.result.length + (controller.hasMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < controller.result.length) {
                final song = controller.result[index];

                final isCurrent =
                    controller.currentTrack.value == song.audio;
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),

                  color: Colors.white12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        song.image ?? "" ,
                        width: 60.w,
                        height: 60.h,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) => Container(
                              width: 60.w,
                              height: 60.h,
                              color: Colors.white12,
                              child: Icon(
                                Icons.music_note,
                                color: Colors.white,
                              ),
                            ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Column(
                          spacing: 2,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              song.name ?? '',
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                            Text(
                              song.artistName ?? "",
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(
                              song.albumName ?? "",

                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white38,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        icon: Icon(isCurrent ? Icons.stop : Icons.play_arrow),
                        onPressed: () {
                          if (isCurrent) {
                            controller.stopTrack();
                          } else {
                            controller.playTrack(song.audio ?? "");
                          }
                        },
                      ),

                      IconButton(
                        icon: Icon(Icons.download),
                        onPressed: () {
                          controller.downloadMusicOffline(
                            song.audiodownload ?? "",
                            song.name ?? "track",
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          );
        }),
      ),
    );
  }
}
