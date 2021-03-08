import 'package:aoli/component/image.dart';
import 'package:aoli/component/pickers/date_picker_dialog.dart';
import 'package:aoli/component/utilList.dart';
import 'package:aoli/events/eventBus.dart';
import 'package:aoli/stores/news_store.dart';
import 'package:aoli/utils/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'news_item.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  final NewsStore newsStore = NewsStore();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsStore.getNewsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 375.w,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFF1E1E1E),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
                width: 375.w,
                height: 88.h,
                color: Color(0xFF0377D1),
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 12.w, bottom: 8.h, right: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child: Text(
                      '傲利资讯',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.sp,
                          fontFamily: 'PingFang',
                          fontWeight: FontWeight.w600),
                    )),
                    InkWell(
                      onTap: () async {
                        var result = await openDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030));
                        print('$result');
                      },
                      child: Img(
                          url: 'asset/images/icon_rili_sel.png',
                          width: 22.h,
                          height: 22.h),
                    )
                  ],
                )),
            Expanded(
                child: Observer(
              builder: (_) => newsStore.loading
                  ? Container()
                  : LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                      return Container(
                          padding: EdgeInsets.only(top: 14.h),
                          child: UtilList(
                            itemCount: newsStore.newsData.length,
                            header: Container(
                              height: 40.0,
                              child:
                                  Center(child: CupertinoActivityIndicator()),
                            ),
                            footer: Container(
                              height: 40.0,
                              child:
                                  Center(child: CupertinoActivityIndicator()),
                            ),
                            // reverse: true,
                            onLoadBefore: () async {
                              await newsStore.getNewsData(refresh:true);
                            },
                            onLoadMore: () async {
                              EventBus.instance
                                  .commit(EventKeys.AddBottomPadding);
                            },
                            bottomContentPadding:
                                constraints.constrainHeight() - 32.h,
                            // loadMoreDone: update,
                            itemBuilder: (index) {
                              if (newsStore.newsData[index] == null) {
                                return WeekLine();
                              }
                              return NewsItem(
                                onFoldTap: () async {
                                  itemScrollController.scrollTo(
                                      index: index + 1,
                                      duration: Duration(milliseconds: 1));
                                },
                                newsData: newsStore.newsData[index],
                                isFirst: index == 0,
                                isLast: index == newsStore.newsData.length - 1,
                              );
                            },
                            controller: itemScrollController,
                          ));
                    }),
            ))
          ],
        ),
      ),
    );
  }
}

class WeekLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: 375.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 18.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6.w)),
                          border: Border.all(
                              width: 2.w, color: Color(0xFF0477D1)))),
                  Container(
                    width: 1.w,
                    height: 23.h,
                    color: Color(0xFFDBDBDE),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
