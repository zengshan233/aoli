import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:aoli/component/image.dart';
import 'package:aoli/route/util_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color(0xFF080903),
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    child: Text('Hello,您好',
                        style: TextStyle(
                            color: Color(0xFFEEEEEE), fontSize: 50.sp)),
                  ),
                  Container(
                    child: TyperAnimatedTextKit(
                      speed: Duration(milliseconds: 100),
                      totalRepeatCount: 1,
                      isRepeatingAnimation: false,
                      text: ["欢迎使用傲利资本app，感激与您在此的相遇。"],
                      textStyle:
                          TextStyle(color: Color(0xFFCCCCCC), fontSize: 15.sp),
                      pause: Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              width: 375.w,
              height: 92.h,
              padding: EdgeInsets.only(right: 30.h),
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  UtilRoute.pushNamed('login');
                },
                child: Img(
                    url: 'asset/images/icon_enter.png',
                    width: 62.h,
                    height: 62.h),
              )),
        ],
      ),
    ));
  }
}
