import 'dart:math';

import 'package:aoli/component/image.dart';
import 'package:aoli/pages/settings/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsAccount extends StatefulWidget {
  @override
  _SettingsAccountState createState() => _SettingsAccountState();
}

class _SettingsAccountState extends State<SettingsAccount> {
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
                  child: Text('账户与安全',
                      style: TextStyle(color: Colors.white, fontSize: 28.sp))),
              SettingItem(
                text: '昵称',
                info:'Dale Goodman'
              ),
              SettingItem(
                text: '手机号码',
              ),
              SettingItem(
                text: '修改密码',
              )
            ],
          )),
    );
  }
}
