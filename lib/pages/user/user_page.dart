import 'package:aoli/component/image.dart';
import 'package:aoli/route/util_route.dart';
import 'package:aoli/stores/user_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final UserStore userStore = UserStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 375.w,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFF1E1E1E),
        child: Stack(
          children: [
            Container(
                width: 375.w,
                height: 220.h,
                padding: EdgeInsets.only(top: 70.h),
                decoration: BoxDecoration(
                    color: Color(0xFF0377D1),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60))),
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 5.h),
                        child: Text(userStore.userInfo.username,
                            style: TextStyle(
                                color: Colors.white, fontSize: 30.sp))),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Img(
                            url: 'asset/images/icon_vip.png',
                            width: 17.h,
                            height: 17.h,
                          )
                        ],
                      ),
                    )
                  ],
                )),
            Positioned(
                width: 375.w,
                height: 290.h,
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  InkWell(
                    onTap: () async{
                      final _picker = ImagePicker();
                      	PickedFile image = await _picker.getImage(source:ImageSource.gallery);

                      // _alyOss.upload(UploadRequest(_uuid.v4(), bucketName,
                      //     'flutter/a.jpg', image.absolute.path));
                    },
                    child: Container(
                        width: 140.h,
                        height: 140.h,
                        decoration: BoxDecoration(
                            color: Color(0xFF1E1E1E),
                            borderRadius:
                                BorderRadius.all(Radius.circular(70.h))),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60.h)),
                                  child: Container(
                                    width: 120.h,
                                    height: 120.h,
                                    child: Img(
                                      url: userStore.userInfo.avatar.isEmpty
                                          ? 'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1441836571,2166773131&fm=26&gp=0.jpg'
                                          : userStore.userInfo.avatar,
                                      fit: BoxFit.cover,
                                    ),
                                  ))
                            ])),
                  ),
                ])),
            Positioned(
                top: 300.h,
                width: 375.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 50.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                'Hello world！',
                                style: TextStyle(
                                    color: Color(0xFFEEEEEE), fontSize: 14.sp),
                              ),
                            ),
                            InkWell(
                                onTap: () {},
                                child: Container(
                                  width: 16.h,
                                  height: 16.h,
                                  child: Img(url: 'asset/images/icon_edit.png'),
                                ))
                          ],
                        )),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: () {},
                            child: Container(
                                child: Column(
                              children: [
                                Container(
                                  width: 30.h,
                                  height: 30.h,
                                  margin: EdgeInsets.only(bottom: 2.h),
                                  child: Img(url: 'asset/images/icon_kefu.png'),
                                ),
                                Container(
                                  child: Text(
                                    '订阅',
                                    style: TextStyle(
                                        color: Color(0xFFCACACA),
                                        fontSize: 14.sp),
                                  ),
                                ),
                              ],
                            ))),
                        InkWell(
                            onTap: () {},
                            child: Container(
                                child: Column(
                              children: [
                                Container(
                                  width: 30.h,
                                  height: 30.h,
                                  margin: EdgeInsets.only(bottom: 2.h),
                                  child: Img(url: 'asset/images/icon_kefu.png'),
                                ),
                                Container(
                                  child: Text(
                                    '收藏',
                                    style: TextStyle(
                                        color: Color(0xFFCACACA),
                                        fontSize: 14.sp),
                                  ),
                                ),
                              ],
                            ))),
                        InkWell(
                            onTap: () {},
                            child: Container(
                                child: Column(
                              children: [
                                Container(
                                  width: 30.h,
                                  height: 30.h,
                                  margin: EdgeInsets.only(bottom: 2.h),
                                  child: Img(url: 'asset/images/icon_kefu.png'),
                                ),
                                Container(
                                  child: Text(
                                    '客服',
                                    style: TextStyle(
                                        color: Color(0xFFCACACA),
                                        fontSize: 14.sp),
                                  ),
                                ),
                              ],
                            ))),
                        InkWell(
                            onTap: () {
                              UtilRoute.pushNamed('settings');
                            },
                            child: Container(
                                child: Column(
                              children: [
                                Container(
                                  width: 30.h,
                                  height: 30.h,
                                  margin: EdgeInsets.only(bottom: 2.h),
                                  child:
                                      Img(url: 'asset/images/icon_shezhi.png'),
                                ),
                                Container(
                                  child: Text(
                                    '设置',
                                    style: TextStyle(
                                        color: Color(0xFFCACACA),
                                        fontSize: 14.sp),
                                  ),
                                ),
                              ],
                            )))
                      ],
                    )),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
