import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mood_tune/util/extention/with_spacer.dart';
import '../generated/assets.dart';
import '../reusable/elevated_button.dart';
import '../reusable/formwidget.dart';
import '../reusable/icons.dart';
import '../util/extention/validators.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();

  static const String routeName = '/SignUp';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => const SignUp(),
    );
  }
}

class _SignUpState extends State<SignUp> {
  //TextEditingController controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //focus node
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  //key
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100.h),

              //logo
              Image.asset(Assets.imgLogo, height: 50.h, width: 150.w),

              //sign up text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New to MoodTunes?",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 26.sp,
                    ),
                  ),
                  Text(
                    " Sign Up",
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              //form
              Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    formWidget(
                      text: "Name",
                      controller: _nameController,
                      focusNode: _nameFocus,
                      hintText: "Enter name/username",
                      inputAction: TextInputAction.next,
                      validator: (value) => Validator.validateName(value),
                    ),
                    formWidget(
                      validator: (value) => Validator.validateEmail(value),

                      text: "Email",
                      controller: _emailController,
                      focusNode: _emailFocus,
                      hintText: "Enter your email",
                      inputAction: TextInputAction.next,
                    ),
                    formWidget(
                      validator: (value) => Validator.validatePassword(value),
                      text: "Password",
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      hintText: "Enter your password",
                      inputAction: TextInputAction.next,
                    ),
                    formWidget(
                      validator:
                          (value) => Validator.validateConfirmPassword(
                            value,
                            _passwordController.text,
                          ),

                      text: "Confirm Password",
                      controller: _confirmPassword,
                      focusNode: _confirmPasswordFocus,
                      hintText: "Confirm your password",
                      inputAction: TextInputAction.done,
                    ),
                  ].withSeparator(SizedBox(height: 10.h)),
                ),
              ),

              //login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an Account?",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Login.",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              //sign up button
              customButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    Navigator.of(context).pop();
                  }
                },
                name: "Sign Up",
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

              //google button
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
                      svgImg(height: 20.h, width: 20.h, img: Assets.imgGoogle),
                      Text("Continue With Google"),
                    ],
                  ),
                ),
              ),
            ].withSeparator(SizedBox(height: 25.h)),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {

    _emailController.dispose();
    _confirmPassword.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _nameFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }
}
