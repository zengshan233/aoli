import 'package:aoli/component/image.dart';
import 'package:aoli/component/login_input.dart';
import 'package:aoli/pages/main_page.dart';
import 'package:aoli/route/util_route.dart';
import 'package:aoli/stores/login_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginStore loginStore = LoginStore();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

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
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Container(
              width: 375.w,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 335.w,
                    margin: EdgeInsets.fromLTRB(5.w, 0, 0, 30.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          child: Text(
                            '欢迎来到',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color(0xFFEEEEEE), fontSize: 15.sp),
                          ),
                        ),
                        Container(
                          child: Text(
                            '傲利资本',
                            style: TextStyle(
                                color: Color(0xFFEEEEEE), fontSize: 30.sp),
                          ),
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
                                borderRadius: BorderRadius.all(
                                  Radius.circular(14),
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LoginInput(
                                    headText: '账号',
                                    hintText: "请输入邮箱号",
                                    inputType: TextInputType.emailAddress,
                                    onChanged: (v) {
                                      loginStore.email = v;
                                    }),
                                LoginInput(
                                  headText: '密码',
                                  hintText: "请输入密码",
                                  obscureText: true,
                                  onChanged: (v) {
                                    loginStore.password = v;
                                  },
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
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
                                            ),
                                          )),
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
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          width: 335.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundedLoadingButton(
                                width: 62.w,
                                height: 62.w,
                                // borderRadius: 31.w,
                                child: Img(
                                    url: 'asset/images/icon_login.png',
                                    width: 62.w,
                                    height: 62.w),
                                controller: _btnController,
                                onPressed: () {
                                  loginStore.login(success: () async {
                                    _btnController.success();
                                    await Future.delayed(
                                        Duration(milliseconds: 1500));
                                    UtilRoute.pushNamed('main', replace: true);
                                  }, failed: () async {
                                    _btnController.error();
                                    await Future.delayed(
                                        Duration(milliseconds: 1500));
                                    _btnController.reset();
                                  });
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
