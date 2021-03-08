import 'dart:async';
import 'dart:convert';

import 'package:aoli/config/application.dart';
import 'package:aoli/utils/http.dart';
import 'package:aoli/utils/http_request.dart';
import 'package:http/http.dart' as http;

import 'login_service.dart';

/// 注册请求服务
class RegisterService {
  /// 用户姓名
  final String name;

  /// 用户邮箱
  final String email;

  /// 用户密码
  final String password;

  RegisterService({this.name, this.email, this.password});

  Future<UserData> send() async {
    Map<String, dynamic> data = {
      'username': name,
      'email': email,
      'password': password
    };
    Uri httpUri = Uri(host: Application.baseHost, scheme: 'http://', path: '/login/register');
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

