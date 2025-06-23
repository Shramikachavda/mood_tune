import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mood_tune/global_binding/global_binding.dart';
import 'package:mood_tune/presentation/album_page_detail/album_page_ui.dart';
import 'package:mood_tune/presentation/bottom_nav/nav_bar_ui.dart';
import 'package:mood_tune/presentation/detail_fetch_music/detail_fetch_music_ui.dart';
import 'package:mood_tune/presentation/home_screen/home_page.dart';
import 'package:mood_tune/presentation/login_screen.dart';
import 'package:mood_tune/presentation/search/search_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(412, 917),
      minTextAdapt: true,
      ensureScreenSize: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MoodTunes',
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xffB181FF),
          scaffoldBackgroundColor: Colors.black,
        ),
        initialRoute: NavBarUi.routeName,
        initialBinding: GlobalBinding(),
        getPages: [
          GetPage(name: NavBarUi.routeName, page: () => NavBarUi()),
          GetPage(name: LogIn.routeName, page: () => LogIn()),
          GetPage(name: HomePage.routeName, page: () => HomePage()),
          GetPage(name: AlbumPageUi.routeName, page: () => AlbumPageUi()),
          GetPage(name: SearchScreen.routeName, page: () => SearchScreen()),
          GetPage(name: DetailFetchMusicUi.routeName, page: () => DetailFetchMusicUi()),
        ],
      ),
    );
  }
}
