import 'package:aoli/component/image.dart';
import 'package:aoli/model/news_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsContent extends StatefulWidget {
  final NewsInfo newsInfo;
  final bool isLastItem;
  final bool isLastContent;
  NewsContent({this.newsInfo, this.isLastItem, this.isLastContent});

  @override
  _NewsContentState createState() => _NewsContentState();
}

class _NewsContentState extends State<NewsContent>
    with AutomaticKeepAliveClientMixin {
  bool showDetail = false;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: IntrinsicHeight(
            child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 18.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 1.w,
                height: 14.h,
                color: Color(0xFFDBDBDE),
              ),
              Container(
                width: 11.h,
                height: 11.h,
                margin: EdgeInsets.symmetric(vertical: 2.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.5.h)),
                    border: Border.all(width: 2.w, color: Color(0xFFDBDBDE))),
              ),
              Expanded(
                  child: Container(
                width: 1.w,
                color: widget.isLastItem && widget.isLastContent && !showDetail
                    ? Colors.transparent
                    : Color(0xFFDBDBDE),
              ))
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 11.h),
            height: 20.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 8.w, height: 1.h, color: Color(0xFFDBDBDE)),
              ],
            )),
        Container(
            margin: EdgeInsets.only(top: 6.h),
            padding: EdgeInsets.only(right: 14.w, top: 5.h, bottom: 6.h),
            decoration: showDetail
                ? BoxDecoration(
                    color: Color(0xFF37373D),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16)))
                : null,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 20.h,
                    child: Row(
                      children: [
                        Container(
                            width: 3.w, height: 1.h, color: Color(0xFFDBDBDE)),
                        Container(
                          width: 4.h,
                          height: 4.h,
                          margin: EdgeInsets.symmetric(vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Color(0xFFDBDBDE),
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.h)),
                          ),
                        ),
                      ],
                    )),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () => setState(() => showDetail = true),
                          child: Container(
                            height: 20.h,
                            margin: EdgeInsets.only(bottom: 6.h),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right:5.w),
                                    constraints:
                                        BoxConstraints(maxWidth: 290.w),
                                    child: Text(widget.newsInfo.title,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Color(0xFFEEEEEE),
                                            fontSize: 15.sp))),
                                showDetail
                                    ? Container()
                                    : Img(
                                        url: 'asset/images/icon_xiala.png',
                                        width: 20.h,
                                        height: 20.h,
                                      )
                              ],
                            ),
                          )),
                      showDetail
                          ? Container(
                              width: 315.w,
                              child: Text(widget.newsInfo.content,
                                  style: TextStyle(
                                      color: Color(0xFFCACACA),
                                      fontSize: 14.sp,
                                      fontFamily: 'PingFang')))
                          : Container(),
                      showDetail
                          ? InkWell(
                              onTap: () => setState(() => showDetail = false),
                              child: Container(
                                  width: 315.w,
                                  alignment: Alignment.centerRight,
                                  child: Img(
                                      url: 'asset/images/icon_shangla.png',
                                      width: 22.h,
                                      height: 22.h)))
                          : Container()
                    ],
                  ),
                )
              ],
            ))
      ],
    )));
  }
}
