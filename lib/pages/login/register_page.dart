import 'package:aoli/component/login_input.dart';
import 'package:aoli/route/util_route.dart';
import 'package:aoli/stores/register_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterStore registerStore = RegisterStore();
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
          color: Color(0xFF1E1E1E),
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
                  margin: EdgeInsets.fromLTRB(5.w, 0, 5.w, 30.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          '傲利资本',
                          style: TextStyle(
                              color: Color(0xFFEEEEEE), fontSize: 30.sp),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          UtilRoute.pop();
                        },
                        child: Container(
                          child: Text(
                            '登录',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color(0xFFB1B1B1), fontSize: 16.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 335.w,
                  height: 386.w,
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
                              LoginInput(
                                headText: '姓名',
                                hintText: "请输入姓名",
                                onChanged: (v) {
                                  registerStore.name = v;
                                },
                              ),
                              LoginInput(
                                headText: '邮箱地址',
                                hintText: "请输入邮箱号",
                                inputType: TextInputType.emailAddress,
                                onChanged: (v) {
                                  registerStore.email = v;
                                },
                              ),
                              LoginInput(
                                headText: '密码',
                                hintText: "请输入密码",
                                obscureText: true,
                                onChanged: (v) {
                                  registerStore.password = v;
                                },
                              ),
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
                              width: 260.w,
                              height: 44.w,
                              // borderRadius: 22.w,
                              child: Text(
                                '注册',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.sp),
                              ),
                              controller: _btnController,
                              onPressed: () {
                                 
                                registerStore.register(success: () async {
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
          )),
        ),
      ),
    );
  }
}
