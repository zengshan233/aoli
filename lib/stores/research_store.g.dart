// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'research_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ResarchStore on _ResarchStore, Store {
  final _$researchTypeAtom = Atom(name: '_ResarchStore.researchType');

  @override
  ResearchType get researchType {
    _$researchTypeAtom.reportRead();
    return super.researchType;
  }

  @override
  set researchType(ResearchType value) {
    _$researchTypeAtom.reportWrite(value, super.researchType, () {
      super.researchType = value;
    });
  }

  final _$researchDataAtom = Atom(name: '_ResarchStore.researchData');

  @override
  List<NewsData> get researchData {
    _$researchDataAtom.reportRead();
    return super.researchData;
  }

  @override
  set researchData(List<NewsData> value) {
    _$researchDataAtom.reportWrite(value, super.researchData, () {
      super.researchData = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ResarchStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$getResearchDataAsyncAction =
      AsyncAction('_ResarchStore.getResearchData');

  @override
  Future<dynamic> getResearchData({bool refresh = false}) {
    return _$getResearchDataAsyncAction
        .run(() => super.getResearchData(refresh: refresh));
  }

  final _$_ResarchStoreActionController =
      ActionController(name: '_ResarchStore');

  @override
  void changeTap(ResearchType type) {
    final _$actionInfo = _$_ResarchStoreActionController.startAction(
        name: '_ResarchStore.changeTap');
    try {
      return super.changeTap(type);
    } finally {
      _$_ResarchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
researchType: ${researchType},
researchData: ${researchData},
loading: ${loading}
    ''';
  }
}
