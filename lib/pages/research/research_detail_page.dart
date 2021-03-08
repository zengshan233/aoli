import 'dart:math';

import 'package:aoli/component/image.dart';
import 'package:aoli/route/util_route.dart';
import 'package:aoli/services/news_service.dart';
import 'package:aoli/stores/research_detail_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResearchDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ResearchDetailPageState();
}

class ResearchDetailPageState extends State<ResearchDetailPage> {
  final ResearchDetailStore detailStore = ResearchDetailStore();
  NewsData listItem;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listItem = UtilRoute.arguments;
    detailStore.getDetail(listItem.id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    detailStore.resetState();
  }

  @override
  Widget build(BuildContext context) {
    print(detailStore.progress);
    return Scaffold(
        body: Container(
      color: Color(0xFF1E1E1E),
      child: Stack(
        children: [
          Positioned.fill(
              child: Column(
            children: [
              Hero(
                tag: listItem.id,
                child: Container(
                  child: Img(url: listItem.thumb, width: 375.w),
                ),
              ),
              Expanded(
                child: Observer(
                    builder: (_) => detailStore.loading
                        ? Container()
                        : Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 18.h, bottom: 6.h),
                                padding:
                                    EdgeInsets.only(left: 22.w, right: 12.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width: 300.w,
                                        child: Text(
                                            detailStore.detailData.title,
                                            style: TextStyle(
                                                color: Color(0xFFEEEEEE),
                                                fontSize: 20.sp))),
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                              width: 20.w,
                                              height: 20.w,
                                              margin:
                                                  EdgeInsets.only(right: 5.w),
                                              child: Img(
                                                url:
                                                    'asset/images/icon_like.png',
                                              )),
                                          Container(
                                              child: Text(
                                                  detailStore
                                                      .detailData.likecount,
                                                  style: TextStyle(
                                                      color: Color(0xFFEEEEEE),
                                                      fontSize: 14.sp)))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.only(left: 22.w, right: 22.w),
                                child: Text(detailStore.detailData.content,
                                    style: TextStyle(
                                        color: Color(0xFFA8A8A8),
                                        fontSize: 13.sp)),
                              ),
                            ],
                          )),
              ),
              Container(
                  height: 78.h,
                  child: Column(
                    children: [
                      InkWell(
                          child: Container(
                            width: 216.w,
                            height: 40.h,
                            child: Row(
                              children: [
                                Container(
                                  width: 60.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFA9D9FF),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          detailStore.follow();
                                        },
                                        child: Container(
                                            child: Observer(
                                          builder: (_) => Icon(
                                              detailStore.detailData
                                                          ?.isfollow ==
                                                      1
                                                  ? Icons.star
                                                  : Icons.star_border,
                                              color: Color(0xFF0377D1)),
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF0377D1),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20))),
                                    alignment: Alignment.center,
                                    child: Observer(builder: (_) {
                                      String fileStatuStr;
                                      if (detailStore.taskStatus ==
                                          DOWNLOAD_PROGRESS) {
                                        fileStatuStr =
                                            "正在下载...${detailStore.progress}%";
                                      } else if (detailStore.taskStatus ==
                                          DOWNLOAD_SUCCESS) {
                                        fileStatuStr = "打开文件";
                                      } else {
                                        fileStatuStr = "PDF下载";
                                      }
                                      return Text(fileStatuStr,
                                          style: TextStyle(
                                              color: Color(0xFFEEEEEE),
                                              fontSize: 16.sp));
                                    }),
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: detailStore.download)
                    ],
                  ))
            ],
          )),
          Positioned(
              top: 40.h,
              child: Container(
                width: 375.w,
                height: 30.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        UtilRoute.pop();
                      },
                      child: Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 16.w),
                          child: Transform.rotate(
                              angle: 1 * pi,
                              child: InkWell(
                                child: Img(
                                    url: 'asset/images/icon_fanhui.png',
                                    width: 20.h,
                                    height: 20.h),
                              ))),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(right: 16.w),
                        child: InkWell(
                          child: Img(
                              url: 'asset/images/icon_share.png',
                              width: 20.h,
                              height: 20.h),
                        )),
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
