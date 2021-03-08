import 'package:aoli/services/login_service.dart';
import 'package:mobx/mobx.dart';
part 'user_store.g.dart';

/// 用户 store
class UserStore extends _UserStore with _$UserStore {
  static UserStore _instance;
  factory UserStore() => _instance ??= UserStore._();
  UserStore._() : super();
}

abstract class _UserStore with Store {
  @observable
  UserData userInfo;

  @action
  updateUser(UserData data) {
    userInfo = data;
  }
}
