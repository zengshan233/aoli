import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginInput extends StatefulWidget {
  final String headText;
  final String hintText;
  final ValueChanged Function(String) onChanged;
  final TextInputType inputType;
  final bool obscureText;
  LoginInput(
      {@required this.headText,
      @required this.hintText,
      this.onChanged,
      this.inputType,
      this.obscureText = false});

  @override
  LoginInputState createState() => LoginInputState(
      headText: headText,
      hintText: hintText,
      onChanged: onChanged,
      inputType: inputType,
      obscureText: obscureText);
}

class LoginInputState extends State<LoginInput> {
  final String headText;
  final String hintText;
  final ValueChanged Function(String) onChanged;
  final TextInputType inputType;
  final bool obscureText;
  LoginInputState(
      {@required this.headText,
      @required this.hintText,
      this.onChanged,
      this.inputType,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              headText,
              style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 20.sp),
            ),
          ),
          Container(
            child: TextField(
              obscureText: obscureText,
              style: TextStyle(color: Color(0xFFEEEEEE)),
              // onChanged: (value) => onChanged(value),
              keyboardType: inputType ?? TextInputType.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(2.w, 0, 0, 0),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff616161),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  //选中时外边框颜色
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Color(0xff0377D1),
                  ),
                ),
                focusColor: Color(0xff0377D1),
                hintText: hintText,
                hintStyle: TextStyle(color: Color(0xff797981), fontSize: 14.sp),
              ),
            ),
          )
        ],
      ),
    );
  }
}
