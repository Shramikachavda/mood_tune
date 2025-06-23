import 'package:floating_bubbles/floating_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoodScreen extends StatelessWidget {
  static const String routeName = '/MoodScreen';

  Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => MoodScreen(),
    );
  }

  final List<String> moods = [
    'Happy',
    'Sad',
    'Love',
    'Chill',
    'Angry',
    'Blessed',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            //bg
            Positioned.fill(
              child: FloatingBubbles(
                noOfBubbles: 40,
                colorsOfBubbles: [Colors.grey.withAlpha(30), Colors.white],
                sizeFactor: 0.16,
                duration: 200,
                opacity: 50,
                paintingStyle: PaintingStyle.fill,
                strokeWidth: 8,
                shape: BubbleShape.circle,
                speed: BubbleSpeed.slow,
              ),
            ),

            // list view
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
              child: Column(
                children: [
                  Text(
                    "SELECT YOUR MOOD",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 32.sp,
                    ),
                  ),

                  Expanded(
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 200.h,
                      diameterRatio: 1,
                      physics: BouncingScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        print(index);
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          final moodName = moods[index];
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xffB181FF),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/img/$moodName.png",
                                  height: 140.h,

                                  fit: BoxFit.contain,
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  moodName,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        childCount: moods.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
