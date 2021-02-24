import 'package:aoli/component/image.dart';
import 'package:aoli/component/login_input.dart';
import 'package:aoli/route/util_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
        gestures: [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: Scaffold(
            body: Container(
          width: 375.w,
          height: MediaQuery.of(context).size.height,
          color: Color(0xFF1E1E1E),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 335.w,
                margin: EdgeInsets.fromLTRB(5.w, 100.h, 0, 30.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: Text('欢迎来到',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color(0xFFEEEEEE), fontSize: 15.sp)),
                    ),
                    Container(
                      child: Text('傲利资本',
                          style: TextStyle(
                              color: Color(0xFFEEEEEE), fontSize: 30.sp)),
                    ),
                  ],
                ),
              ),
              Container(
                  width: 335.w,
                  height: 395.w,
                  child: Stack(
                    children: [
                      Positioned(
                          child: Container(
                        width: 335.w,
                        height: 364.w,
                        padding: EdgeInsets.fromLTRB(20.w, 30.w, 20.w, 0),
                        decoration: BoxDecoration(
                            color: Color(0xFF37373D),
                            borderRadius:
                                BorderRadius.all(Radius.circular(14))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Container(
                            //   margin: EdgeInsets.only(bottom: 30.w),
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Container(
                            //         child: Text(
                            //           '账号',
                            //           style: TextStyle(
                            //               color: Color(0xFFEEEEEE),
                            //               fontSize: 20.sp),
                            //         ),
                            //       ),
                            //       Container(
                            //         child: TextField(
                            //           controller: TextEditingController(),
                            //           style:
                            //               TextStyle(color: Color(0xFFEEEEEE)),
                            //           keyboardType: TextInputType.text,
                            //           decoration: InputDecoration(
                            //             contentPadding:
                            //                 EdgeInsets.fromLTRB(2.w, 0, 0, 0),
                            //             enabledBorder: UnderlineInputBorder(
                            //               borderSide: BorderSide(
                            //                 color: Color(0xff616161),
                            //               ),
                            //             ),
                            //             focusedBorder: UnderlineInputBorder(
                            //               //选中时外边框颜色
                            //               borderRadius:
                            //                   BorderRadius.circular(5.0),
                            //               borderSide: BorderSide(
                            //                 color: Color(0xff0377D1),
                            //               ),
                            //             ),
                            //             focusColor: Color(0xff0377D1),
                            //             hintText: '请输入邮箱号',
                            //             hintStyle: TextStyle(
                            //                 color: Color(0xff797981),
                            //                 fontSize: 14.sp),
                            //           ),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                         
                            LoginInput(
                              headText: '账号',
                              hintText: "请输入邮箱号",
                              inputType: TextInputType.emailAddress,
                              // onChanged: (v) {
                              //   print(v);
                              // },
                            ),
                            LoginInput(
                              headText: '密码',
                              hintText: "请输入密码",
                              obscureText: true,
                              onChanged: (v) {
                                print(v);
                              },
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                          child: Text(
                                        '忘记密码？',
                                        style: TextStyle(
                                            color: Color(0xFFB1B1B1),
                                            fontSize: 14.sp),
                                      ))),
                                  GestureDetector(
                                      onTap: () {
                                        UtilRoute.pushNamed('register');
                                      },
                                      child: Container(
                                        child: Text(
                                          '注册',
                                          style: TextStyle(
                                              color: Color(0xFFB1B1B1),
                                              fontSize: 14.sp),
                                        ),
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                      Positioned(
                          bottom: 0,
                          width: 335.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  print('?');
                                },
                                child: Img(
                                    url: 'asset/images/icon_login.png',
                                    width: 62.w,
                                    height: 62.w),
                              ),
                            ],
                          ))
                    ],
                  )),
            ],
          )),
        )));
  }
}
