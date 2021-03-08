import 'package:aoli/component/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSwiper extends StatefulWidget {
  @override
  _HomeSwiperState createState() => _HomeSwiperState();
}

class _HomeSwiperState extends State<HomeSwiper> {
  SwiperController controller = SwiperController();
  int swiperIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 100.h,
            margin: EdgeInsets.only(bottom: 6.w),
            child: new Swiper(
              scrollDirection: Axis.horizontal,
              controller: controller,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                      color: Color(0xFF1E1E1E),
                      width: 280.w,
                      height: 100.h,
                      child: Img(
                          url:
                              "http://hbimg.b0.upaiyun.com/a3e592c653ea46adfe1809e35cd7bc58508a6cb94307-aaO54C_fw658")),
                );
              },
              itemCount: 6,
              autoplay: true,
              onTap: (index) {
                print(" 点击 " + index.toString());
              },
              onIndexChanged: (index) {
                setState(() {
                  swiperIndex = index;
                });
              },
              viewportFraction: 0.7,
              autoplayDisableOnInteraction: true,
              loop: true,
              scale: 0.8,
            ),
          ),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(6, (index) {
              bool isLooped = swiperIndex == index;
              return Container(
                  height: 6.w,
                  width: isLooped ? 16.w : 6.w,
                  margin: EdgeInsets.only(right: 3.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3.w)),
                      color: isLooped ? Color(0xFF9547E8) : Color(0xFF535562)));
            }),
          ))
        ],
      ),
    );
  }
}
