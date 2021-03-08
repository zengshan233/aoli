import 'package:aoli/component/image.dart';
import 'package:aoli/route/util_route.dart';
import 'package:aoli/services/news_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';

class ResearchItem extends StatelessWidget {
  final NewsData item;
  ResearchItem({this.item});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return InkWell(
      onTap: () {
        UtilRoute.pushNamed('researchDetail', params: item);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h, left: 12.w, right: 12.w),
        decoration: BoxDecoration(
            color: Color(0xFF37373D),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IntrinsicHeight(
                child: Container(
              height: 89.h,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 200.w,
                            margin: EdgeInsets.only(bottom: 5.h),
                            child: Text(item.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color(0xFFEEEEEE), fontSize: 16.sp)),
                          ),
                          Container(
                            width: 210.w,
                            child: Text(item.content,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                    color: Color(0xFFA8A8A8), fontSize: 13.sp)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Text(
                          item.createtime.split(' ').first.replaceAll('-', '/'),
                          style: TextStyle(
                              color: Color(0xFFA8A8A8), fontSize: 12.sp)),
                    )
                  ]),
            )),
            // ClipRect()
            Hero(
                tag: item.id,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                        width: 89.h,
                        height: 89.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: Img(
                          url: item.thumb,
                          fit: BoxFit.cover,
                        ))))
          ],
        ),
      ),
    );
  }
}
