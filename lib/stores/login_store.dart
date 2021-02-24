
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

/// 消息@ store
class LoginStore extends _LoginStore with _$LoginStore {
  static LoginStore _instance;
  factory LoginStore() => _instance ??= LoginStore._();
  LoginStore._() : super();
}

abstract class _LoginStore with Store {
}