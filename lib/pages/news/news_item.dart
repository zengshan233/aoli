import 'dart:math';

import 'package:aoli/component/image.dart';
import 'package:aoli/events/eventBus.dart';
import 'package:aoli/utils/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import 'news_content.dart';

class NewsItem extends StatefulWidget {
  final String date;
  final Function onFoldTap;
  final bool isLast;
  final bool isFirst;
  NewsItem({this.date, this.onFoldTap, this.isLast,this.isFirst});
  @override
  _NewsItemState createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  bool showMore = false;
  final ScrollController controller = ScrollController();
  double offset;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isFirst){
         showMore = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StickyHeader(
        callback: (double _offset) {
          offset = _offset;
        },
        header: Container(
          color: Color(0xFF1E1E1E),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    setState(() => showMore = !showMore);
                    if (showMore) {
                    
                    } else {
                      if (widget.isLast) {
                        EventBus.instance.commit(EventKeys.AddBottomPadding);
                      }
                      if (offset < 0) {
                        widget.onFoldTap();
                      }
                    }
                  },
                  child: Container(
                    // padding: EdgeInsets.only(left: 12.w, bottom: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Img(
                                  url: 'asset/images/icon_rili.png',
                                  width: 18.h,
                                  height: 18.h),
                              Container(
                                margin: EdgeInsets.only(left: 6.w, right: 14.w),
                                child: Text(
                                  widget.date,
                                  style: TextStyle(
                                      color: Color(0xFFEEEEEE),
                                      fontSize: 18.sp,
                                      fontFamily: 'pmzdbtt'),
                                ),
                              ),
                              Transform.rotate(
                                  angle: (showMore ? 2 : 1) * pi,
                                  child: Img(
                                      url: 'asset/images/xiala.png',
                                      height: 14.h,
                                      width: 14.h))
                            ],
                          ),
                        ),
                        widget.date != null
                            ? Container(
                                margin: EdgeInsets.only(right: 12.w),
                                child: Text(
                                    DateUtil.getZHWeekDay(DateUtil.getDateTime(
                                        widget.date)),
                                    style: TextStyle(
                                        color: Color(0xFFEEEEEE),
                                        fontSize: 13.sp)),
                              )
                            : Container()
                      ],
                    ),
                  )),
            ],
          ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showMore
                ? Column(
                    children: List.generate(
                       7,
                        (index) => NewsContent(
                              isLastItem: widget.isLast,
                              isLastContent: index == 14,
                            )))
                : Container(),
            widget.isLast
                ? Container()
                : Container(
                    width: 18.h,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 1.w,
                            height: 23.h,
                            color: Color(0xFFDBDBDE),
                          ),
                         
                        ]))
          ],
        ));
  }
}
