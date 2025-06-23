import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mood_tune/presentation/sign_up.dart';
import 'package:mood_tune/util/extention/with_spacer.dart';
import '../generated/assets.dart';
import '../reusable/elevated_button.dart';
import '../reusable/formwidget.dart';
import '../reusable/icons.dart';
import '../util/extention/validators.dart';
import 'home_screen/home_page.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();

  static const String routeName = '/Login';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => const LogIn(),
    );
  }
}

class _LogInState extends State<LogIn> {
  //TextEditingController controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //focus node
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  //key
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Variable to track the back button presses
  int _backPressCount = 0;

  @override
  Widget build(BuildContext context) {
    print("buils");
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        if (_backPressCount == 0) {
          _backPressCount = 1;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Press again to exit")));
        } else {
          if (_backPressCount == 1) {
            // Reset counter
            SystemNavigator.pop();
            _backPressCount = 0;
          }
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100.h),

                //img
                Image.asset(Assets.imgLogo, height: 50.h, width: 150.w),

                Text(
                  "Login To MoodTunes",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30.sp,
                  ),
                ),

                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      formWidget(
                        text: "Email",
                        controller: _emailController,
                        focusNode: _emailFocus,
                        hintText: "Enter your email",
                        inputAction: TextInputAction.next,
                        validator: (value) => Validator.validateEmail(value),
                      ),
                      formWidget(
                        text: "Password",
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        hintText: "Enter your password",
                        inputAction: TextInputAction.done,
                        validator: (value) => Validator.validatePassword(value),
                      ),
                    ].withSeparator(SizedBox(height: 10.h)),
                  ),
                ),

                //remember and forget
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    Text(
                      "Remember me",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Forgot password ?",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),

                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t have an Account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(SignUp.route());
                      },
                      child: Text("Sign Up."),
                    ),
                  ],
                ),

                //button
                customButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).push(HomePage.route());
                    }
                  },
                  name: "LOGIN",
                ),
                //or
                Row(
                  spacing: 5,
                  children: [
                    Expanded(
                      child: Container(height: 2, color: Color(0xffcabbef)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Or"),
                    ),
                    Expanded(
                      child: Container(height: 2, color: Color(0xffcabbef)),
                    ),
                  ],
                ),

                //google
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {},
                  child: Container(
                    height: 55.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(width: 1.5, color: Color(0xffcabbef)),
                    ),
                    child: Row(
                      spacing: 10.w,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        svgImg(
                          height: 20.h,
                          width: 20.h,
                          img: Assets.imgGoogle,
                        ),
                        Text("Continue With Google"),
                      ],
                    ),
                  ),
                ),
              ].withSeparator(SizedBox(height: 25.h)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
  }
}
