import 'dart:math';

import 'package:aoli/component/image.dart';
import 'package:aoli/pages/settings/settings_item.dart';
import 'package:aoli/route/util_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: 375.w,
          height: MediaQuery.of(context).size.height,
          color: Color(0xFF1E1E1E),
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10.h),
          child: Column(
            children: [
              Container(
                  width: 375.w,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 16.w, bottom: 13.h),
                  child: Transform.rotate(
                      angle: 1 * pi,
                      child: InkWell(
                        child: Img(
                            url: 'asset/images/icon_fanhui.png',
                            width: 15.h,
                            height: 15.h),
                      ))),
              Container(
                  width: 375.w,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 30.w, bottom: 45.h),
                  child: Text('设置',
                      style: TextStyle(color: Colors.white, fontSize: 28.sp))),
              SettingItem(
                text: '账户与安全',
                onTap: () => UtilRoute.pushNamed('settings/account'),
              ),
              SettingItem(
                text: '通知设置',
              ),
              SettingItem(
                text: '关于“傲利资本”',
              )
            ],
          )),
    );
  }
}
