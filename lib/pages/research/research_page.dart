import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResearchPage extends StatefulWidget {
  @override
  _ResearchPageState createState() => _ResearchPageState();
}

class _ResearchPageState extends State<ResearchPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                color: Color(0xFF0377D1),
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(top: 40.h, left: 12.w, bottom: 8.h),
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
                      child: TextField(
                        style: TextStyle(color: Color(0xFFEEEEEE)),
                        // onChanged: (value) => onChanged(value),

                        decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding: EdgeInsets.fromLTRB(20.w, 7.h, 0, 7.h),
                          border: InputBorder.none,
                          hintText: '请输入关键词',
                          hintStyle: TextStyle(
                              color: Color(0xff8A8D9E), fontSize: 14.sp),
                        ),
                      ),
                    )
                  ],
                )),
            // Expanded(
            //     child: )
          ],
        ),
      ),
    );
  }
}
