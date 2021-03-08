import 'package:aoli/services/login_service.dart';
import 'package:aoli/services/storage_management.dart';
import 'package:aoli/utils/ToastUtils.dart';
import 'package:mobx/mobx.dart';

import 'user_store.dart';
part 'login_store.g.dart';

/// 消息@ store
class LoginStore extends _LoginStore with _$LoginStore {}

abstract class _LoginStore with Store {
  final UserStore uesrStore = UserStore();
  String _email = '';

  String _password = '';

  set email(String value) {
    _email = value;
  }

  set password(String value) {
    _password = value;
  }

  @observable
  bool loading = false;

  @action
  Future login({Function success, Function failed}) async {
    if ([_email, _password].any((e) => e.isEmpty)) {
      ToastUtils.show('邮箱或密码不可为空');
      failed();
      return;
    }
    if (loading) {
      return;
    }
    loading = true;
    UserData data;
    try {
      data = await LoginService(email: _email, password: _password).send();
    } catch (e) {
      print('e $e');
      ToastUtils.show(e.message);
      loading = false;
      if (failed != null) {
        failed();
      }
      return;
    }
    tokenStorage.set(data.token);
    uesrStore.updateUser(data);
    loading = false;
    ToastUtils.show('登录成功');
    if (success != null) {
      success();
    }
  }
}
