import 'package:aoli/component/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingItem extends StatelessWidget {
  final String text;
  final String info;
  final Function onTap;
  SettingItem({this.text, this.info, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          width: 375.w,
          height: 65.h,
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(text,
                    style:
                        TextStyle(color: Color(0xFFCACACA), fontSize: 16.sp)),
              ),
              Container(
                child: Row(
                  children: [
                    info != null
                        ? Container(
                          margin: EdgeInsets.only(right:5.w),
                            child: Text(text,style:
                        TextStyle(color: Color(0xFFA8A8A8), fontSize: 16.sp)),
                          )
                        : Container(),
                    Img(
                        url: 'asset/images/icon_fanhui.png',
                        width: 15.h,
                        height: 15.h)
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
