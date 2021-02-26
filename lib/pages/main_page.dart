import 'package:aoli/component/image.dart';
import 'package:aoli/pages/fund/fund_page.dart';
import 'package:aoli/pages/home/home_page.dart';
import 'package:aoli/pages/research/research_page.dart';
import 'package:aoli/pages/user/user_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'news/news_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = PageController(viewportFraction: 0.8);

  int _contentIndex = 0;

  List<NavigationBarItem> navigationBars = [
    NavigationBarItem(icon: 'asset/images/icon_home', text: '主页'),
    NavigationBarItem(icon: 'asset/images/icon_zixun', text: '资讯'),
    NavigationBarItem(icon: 'asset/images/icon_baogao', text: '研究报告'),
    NavigationBarItem(icon: 'asset/images/icon_jijin', text: '基金'),
    NavigationBarItem(icon: 'asset/images/icon_me', text: '我的'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: IndexedStack(
                index: _contentIndex,
                children: [
                  HomePage(),
                  NewsPage(),
                  ResearchPage(),
                  FundPage(),
                  UserPage()
                ],
              ),
            )),
            Container(
              width: 375.w,
              height: 50.h,
              padding: EdgeInsets.only(top: 5.h),
              decoration: BoxDecoration(
                  color: Color(0xFF37373D),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  navigationBars.length,
                  (index) => InkWell(
                      onTap: () => setState(() => _contentIndex = index),
                      child: Container(
                        child: Column(
                          children: [
                            Img(
                                url:
                                    '${navigationBars[index].icon}${_contentIndex == index ? '_s' : ''}.png',
                                width: 25.h,
                                height: 25.h),
                            Container(
                              margin: EdgeInsets.only(top: 2.h),
                              child: Text(
                                navigationBars[index].text,
                                style: TextStyle(
                                    color: _contentIndex == index
                                        ? Color(0xFF0377D1)
                                        : Color(0xFFBBBBBB),
                                    fontSize: 11.sp),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NavigationBarItem {
  final String icon;
  final String text;
  NavigationBarItem({this.icon, this.text});
}
