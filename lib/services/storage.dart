import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class Storage<T extends Object> {
  static final Future<SharedPreferences> pref = SharedPreferences.getInstance();

  /// 需要操作的key
  final String key;

  Storage(this.key);

  /// 是否存在
  Future<bool> exist() async {
    return (await pref).containsKey(key);
  }

  /// 获取值
  Future<T> get() async {
    String value = (await pref).getString(key);
    if(value != null) {
      try {
        return json.decode(value);
      } catch(err) {
        print('storage get error $err');
        return null;
      }
    } else {
      return null;
    }
  }

  /// 设置值
  Future<void> set(T value) async {
    (await pref).setString(key, json.encode(value));
  }

  /// 清空值
  Future<void> remove() async {
    return (await pref).remove(key);
  }
}
