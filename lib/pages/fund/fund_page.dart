import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FundPage extends StatefulWidget {
  @override
  _FundPageState createState() => _FundPageState();
}

class _FundPageState extends State<FundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 375.w,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFF1E1E1E),
        alignment: Alignment.center,
      ),
    );
  }
}
