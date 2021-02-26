import 'package:aoli/component/image.dart';
import 'package:aoli/component/pickers/date_picker_dialog.dart';
import 'package:aoli/component/utilList.dart';
import 'package:aoli/events/eventBus.dart';
import 'package:aoli/utils/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  List<String> testList = [
    '2021/02/26',
    '2021/02/25',
    '2021/02/23',
    '2021/02/22',
    '2021/02/20',
    '2021/02/18',
    '2021/02/17',
    '2021/02/16',
    '2021/02/15',
    '2021/02/14',
    '2021/02/13',
    '2021/02/11',
    '2021/02/10',
    '2021/02/08',
    '2021/02/07'
  ];

  List<String> resultList = [];
  bool update = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resultList = calWeek(testList);
  }

  List<String> calWeek(List<String> list) {
    List<String> _resultList = [];
    // list.rede
    String resultString = list.reduce((a, b) {
      String previous =
          a.replaceAll('+', ' ').replaceAll('-', ' ').split(' ').last;
      String result;
      int millSecondsA = DateUtil.getDateTime(previous).millisecondsSinceEpoch;
      int millSecondsB = DateUtil.getDateTime(b).millisecondsSinceEpoch;
      int weekA = DateUtil.getDateTime(previous).weekday;
      int weekB = DateUtil.getDateTime(b).weekday;
      double day = (millSecondsA - millSecondsB) / 1000 / 60 / 60 / 24;
      if (weekA > weekB && day <= 6) {
        result = '$a+$b';
      } else {
        result = '$a-$b';
      }
      return result;
    });
    List<String> splitResult = resultString.split('+');
    splitResult.forEach((r) {
      if (r.contains('-')) {
        List<String> weekSplit = r.split('-');
        _resultList.addAll([weekSplit.first, '-', weekSplit.last]);
      } else {
        _resultList.add(r);
      }
    });
    return _resultList;
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
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                    padding: EdgeInsets.only(top: 14.h),
                    child: UtilList(
                      itemCount: resultList.length,
                      header: Container(
                        height: 40.0,
                        child: Center(child: CupertinoActivityIndicator()),
                      ),
                      footer: Container(
                        height: 40.0,
                        child: Center(child: CupertinoActivityIndicator()),
                      ),
                      // reverse: true,
                      onLoadBefore: () async {
                        await Future.delayed(Duration(seconds: 1));
                        setState(() {
                          List<String> test = [
                            '2021/02/30',
                            '2021/02/29',
                            '2021/02/28',
                            '2021/02/27',
                          ];
                          test.addAll(testList);
                          resultList = calWeek(test);
                        });
                      },
                      onLoadMore: () async {
                        if (update) {
                          return null;
                        }
                        await Future.delayed(Duration(seconds: 1));
                        setState(() {
                          testList.addAll([
                            '2021/02/06',
                            '2021/02/05',
                            '2021/02/04',
                            '2021/02/03',
                            '2021/02/02',
                            '2021/02/01'
                          ]);
                          resultList = calWeek(testList);
                        });
                        setState(() {
                          update = true;
                        });
                        EventBus.instance.commit(EventKeys.AddBottomPadding);
                      },
                      bottomContentPadding:
                          constraints.constrainHeight() - 32.h,
                      loadMoreDone: update,
                      itemBuilder: (index) {
                        if (resultList[index] == '-') {
                          return WeekLine();
                        }
                        return NewsItem(
                          onFoldTap: () async {
                            itemScrollController.scrollTo(
                                index: index + 1,
                                duration: Duration(milliseconds: 1));
                          },
                          date: resultList[index],
                          isFirst: index == 0,
                          isLast: index == resultList.length - 1,
                        );
                      },
                      controller: itemScrollController,
                    ));
              }),
            )
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
