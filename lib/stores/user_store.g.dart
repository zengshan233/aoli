// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  final _$userInfoAtom = Atom(name: '_UserStore.userInfo');

  @override
  UserData get userInfo {
    _$userInfoAtom.reportRead();
    return super.userInfo;
  }

  @override
  set userInfo(UserData value) {
    _$userInfoAtom.reportWrite(value, super.userInfo, () {
      super.userInfo = value;
    });
  }

  final _$_UserStoreActionController = ActionController(name: '_UserStore');

  @override
  dynamic updateUser(UserData data) {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.updateUser');
    try {
      return super.updateUser(data);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userInfo: ${userInfo}
    ''';
  }
}
