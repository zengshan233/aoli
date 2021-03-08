import 'package:aoli/services/login_service.dart';
import 'package:aoli/services/register_service.dart';
import 'package:aoli/services/storage_management.dart';
import 'package:aoli/utils/ToastUtils.dart';
import 'package:mobx/mobx.dart';

import 'user_store.dart';
part 'register_store.g.dart';

/// 注册 store
class RegisterStore extends _RegisterStore with _$RegisterStore {}

abstract class _RegisterStore with Store {
  final UserStore uesrStore = UserStore();
  String _name;

  String _email;

  String _password;
  
  set name(String value) {
    _name = value;
  }

  set email(String value) {
    _email = value;
  }

  set password(String value) {
    _password = value;
  }

  @observable
  bool loading;

  @action
  Future register({Function success, Function failed}) async {
    loading = true;
    UserData data;
    try {
      data = await RegisterService(name:_name,email: _email, password: _password).send();
    } catch (e) {
      print('e $e');
       ToastUtils.show(e.message);
      loading = false;
       if (failed != null) {
        failed();
      }
    }
    tokenStorage.set(data.token);
    uesrStore.updateUser(data);
    loading = false;
    ToastUtils.show('注册成功');
    if (success != null) {
      success();
    }
  }
}
