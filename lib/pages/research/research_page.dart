import 'package:aoli/component/image.dart';
import 'package:aoli/component/utilList.dart';
import 'package:aoli/model/research_model.dart';
import 'package:aoli/stores/research_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import 'research_item.dart';

class ResearchPage extends StatefulWidget {
  @override
  _ResearchPageState createState() => _ResearchPageState();
}

class _ResearchPageState extends State<ResearchPage> {
  final ResarchStore researchStore = ResarchStore();

  final List<RearchTab> tabs = [
    RearchTab(text: '股评', type: ResearchType.comment),
    RearchTab(text: '周报', type: ResearchType.week),
    RearchTab(text: '行研', type: ResearchType.research)
  ];

  EasyRefreshController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    researchStore.getResearchData();
    _controller = EasyRefreshController();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
        gestures: [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: 375.w,
            height: MediaQuery.of(context).size.height,
            color: Color(0xFF1E1E1E),
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 50.h),
            child: Column(
              children: [
                Container(
                    width: 375.w,
                    color: Color(0xFF0377D1),
                    alignment: Alignment.bottomLeft,
                    padding:
                        EdgeInsets.only(top: 40.h, left: 12.w, bottom: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '研究报告',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.sp,
                              fontFamily: 'PingFang',
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                            width: 351.w,
                            margin: EdgeInsets.only(top: 6.h),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.w))),
                            child: Row(
                              children: [
                                Container(
                                  width: 22.w,
                                  height: 22.w,
                                  margin: EdgeInsets.only(left:12.w),
                                  child:
                                      Img(url: 'asset/images/icon_search.png'),
                                ),
                                Container(
                                  width: 300.w,
                                  child:TextField(
                                  style: TextStyle(color: Color(0xFFEEEEEE)),
                                  // onChanged: (value) => onChanged(value),
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(5.w, 7.h, 0, 7.h),
                                    border: InputBorder.none,
                                    hintText: '请输入关键词',
                                    hintStyle: TextStyle(
                                        color: Color(0xff8A8D9E),
                                        fontSize: 14.sp),
                                  ),
                                ),)
                                
                              ],
                            ))
                      ],
                    )),
                Container(
                    padding:
                        EdgeInsets.only(left: 12.w, top: 16.h, bottom: 16.h),
                    child: Observer(
                        builder: (_) => Row(
                            children: tabs
                                .map((e) => InkWell(
                                    onTap: () =>
                                        researchStore.changeTap(e.type),
                                    child: Container(
                                      margin: EdgeInsets.only(right: 30.w),
                                      child: Column(children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 3.h),
                                          child: Text(e.text,
                                              style: researchStore
                                                          .researchType ==
                                                      e.type
                                                  ? TextStyle(
                                                      color: Color(0xFFEEEEEE),
                                                      fontSize: 22.sp)
                                                  : TextStyle(
                                                      color: Color(0xFF8A8D9E),
                                                      fontSize: 16.sp)),
                                        ),
                                        researchStore.researchType == e.type
                                            ? Container(
                                                width: 22.w,
                                                height: 3.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                1.5)),
                                                    color: Color(0xFF0377D1)),
                                              )
                                            : Container()
                                      ]),
                                    )))
                                .toList()))),
                Expanded(
                    child: Observer(
                  builder: (_) => researchStore.loading
                      ? Column(
                          children: [],
                        )
                      : Container(
                          child: EasyRefresh.custom(
                          enableControlFinishRefresh: false,
                          enableControlFinishLoad: true,
                          controller: _controller,
                          header: ClassicalHeader(
                              refreshText: '下拉刷新',
                              textColor: Colors.white,
                              refreshedText: '刷新完成',
                              refreshingText: '刷新中',
                              refreshReadyText: '松开刷新',
                              showInfo: false),
                          footer: ClassicalFooter(),
                          onRefresh: () async {
                            await researchStore.getResearchData(refresh: true);
                          },
                          slivers: <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return ResearchItem(
                                      item: researchStore.researchData[index]);
                                },
                                childCount: researchStore.researchData.length,
                              ),
                            ),
                          ],
                        )),
                )),
              ],
            ),
          ),
        ));
  }
}
