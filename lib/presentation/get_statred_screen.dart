import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mood_tune/reusable/elevated_button.dart';
import '../generated/assets.dart';
import 'mood_screen.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});


  static const String routeName = '/GetStarted';

  Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => const GetStarted(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(Assets.imgLogo, height: 50.h),
              ),
SizedBox(height: 150.h,) ,
              Text(
                "Let's take a  quick tour",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 32.sp),
              ),
              SizedBox(height: 30.h,) ,
              Text(
                "VIBE CHECK",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 44.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30.h,) ,
              Image.asset(Assets.imgMusic, height: 200.h),
              SizedBox(height: 30.h,) ,
              customButton(name: "Let's Check it out", onPressed: () {
                Navigator.of(context).push(MoodScreen().route());
              }),
            ],
          ),
        ),
      ),
    );
  }
}
