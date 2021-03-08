import 'dart:async';
import 'dart:convert';

import 'package:aoli/config/application.dart';
import 'package:aoli/utils/http.dart';
import 'package:aoli/utils/http_request.dart';
import 'package:http/http.dart' as http;

/// 登录请求服务
class LoginService {
  /// 用户邮箱
  final String email;

  /// 用户密码
  final String password;

  LoginService({this.email, this.password});

  Future<UserData> send() async {
    Map<String, dynamic> data = {'email': email, 'password': password};
    Uri httpUri = Uri(host: Application.baseHost, scheme: 'http', path: '/login/emailLogin');
    http.Response response = await http.post(httpUri, body: data);
    Map<String, dynamic> resJson = json.decode(response.body);
    int status = resJson['status'];
    if (status != 1) {
      throw HandleError(message: resJson['error'], code: status);
    }
    UserData result = UserData.fromJson(resJson['data']);
    return result;
  }
}

class UserData {
  String id;
  String phone;
  String email;
  String username;
  String avatar;
  String collectcount;
  String likecount;
  String isdelete;
  String createtime;
  String token;

  UserData(
      {this.id,
      this.phone,
      this.email,
      this.username,
      this.avatar,
      this.collectcount,
      this.likecount,
      this.isdelete,
      this.createtime,
      this.token});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    email = json['email'];
    username = json['username'];
    avatar = json['avatar'];
    collectcount = json['collectcount'];
    likecount = json['likecount'];
    isdelete = json['isdelete'];
    createtime = json['createtime'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['collectcount'] = this.collectcount;
    data['likecount'] = this.likecount;
    data['isdelete'] = this.isdelete;
    data['createtime'] = this.createtime;
    data['token'] = this.token;
    return data;
  }
}
