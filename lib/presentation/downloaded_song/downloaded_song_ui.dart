import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'downloaded_song_controller.dart';

class DownloadedMusicPage extends StatelessWidget {
  DownloadedMusicPage({super.key});

  final DownloadedMusicController controller =
      Get.find<DownloadedMusicController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Downloaded Songs",
          style: TextStyle(color: Color(0xccCABBEf)),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Obx(() {
        if (controller.songs.isEmpty) {
          return Center(child: Text("No songs downloaded"));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: controller.songs.length,
          itemBuilder: (context, index) {
            final file = controller.songs[index];
            final fileName =
                file.path.split('/').last; // get file name from path

            // You may parse fileName to get display-friendly name if needed
            final displayName = fileName.replaceAll('.mp3', '');

            return Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${index + 1}"),

                  Container(
                    padding: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.music_note, color: Colors.grey),
                  ),

                  Expanded(
                    child: Text(
                      displayName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  Obx(() {
                    final isCurrent =
                        controller.currentSong.value?.path == file.path &&
                        controller.isPlaying.value;
                    return IconButton(
                      icon: Icon(isCurrent ? Icons.stop : Icons.play_arrow),
                      onPressed: () {
                        if (isCurrent) {
                          controller.stopSong();
                        } else {
                          controller.playSong(file);
                        }
                      },
                    );
                  }),
                  IconButton(
                    icon: Icon(Icons.delete, color: Color(0xffCABBEf)),
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Delete File",
                        middleText:
                            "Are you sure you want to delete '$displayName'?",
                        textConfirm: "Yes",
                        textCancel: "No",
                        onConfirm: () async {
                          Get.back();
                          await controller.confirmAndDelete(displayName);
                          await controller
                              .loadDownloadedSongs(); // Refresh list after delete
                        },
                        onCancel: () {
                          Get.back();
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
