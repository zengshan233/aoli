import 'package:aoli/component/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeader extends StatefulWidget {
  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  SwiperController controller = SwiperController();
  int swiperIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      margin: EdgeInsets.only(bottom: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 6.w),
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(16.h)),
                    child: Container(
                      width: 32.h,
                      height: 32.h,
                      child: Img(
                        url:
                            'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1441836571,2166773131&fm=26&gp=0.jpg',
                        fit: BoxFit.cover,
                      ),
                    )),
                Container(
                    margin: EdgeInsets.only(left: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                    margin: EdgeInsets.only(bottom: 2.h),
                          child: Text(
                            'Hello world！',
                            style: TextStyle(
                                color: Color(0xFFEEEEEE), fontSize: 13.sp),
                          ),
                        ),
                        InkWell(
                            onTap: () {},
                            child: Container(
                                width: 30.h,
                                height: 16.h,
                                decoration: BoxDecoration(
                                    color: Color(0xFF37373D),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(1),
                                        topRight: Radius.circular(4),
                                        bottomLeft: Radius.circular(4))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Img(
                                      url: 'asset/images/icon_kefu.png',
                                      width: 16.h,
                                      height: 16.h,
                                    ),
                                  ],
                                )))
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
