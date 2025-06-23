import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_tune/presentation/home_screen/home_page.dart';
import '../downloaded_song/downloaded_song_ui.dart';
import '../search/search_screen.dart';
import 'nav_bar_controller.dart';

class NavBarUi extends StatelessWidget {
  NavBarUi({super.key});

  static const String routeName = '/NavBarUi';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => NavBarUi(),
    );
  }

  final List<Widget> _pages = [
    HomePage(),
    SearchScreen(),
    Center(child: Text("3")),
    DownloadedMusicPage(),
  ];

  final controller = Get.find<NavBarController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        bottomSheet: BottomNavigationBar(
          selectedItemColor: Color(0xffCABBEf),
          unselectedItemColor: Colors.white,
          currentIndex: controller.currentIndex.value,
          onTap: controller.updateIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music_outlined),
              label: "Library",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.download_outlined),
              label: "Download",
            ),
          ],
        ),
        body: _pages[controller.currentIndex.value],
      );
    });
  }
}
