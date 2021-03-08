import 'package:aoli/component/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_header.dart';
import 'home_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SwiperController controller = SwiperController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      body: Container(
        padding: EdgeInsets.only(top:MediaQuery.of(context).padding.top + 11.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            HomeHeader(),
            HomeSwiper(),
          ],
        ),
      ),
    );
  }
}
