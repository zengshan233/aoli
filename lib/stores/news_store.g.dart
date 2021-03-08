// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewsStore on _NewsStore, Store {
  final _$loadingAtom = Atom(name: '_NewsStore.loading');

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

  final _$newsDataAtom = Atom(name: '_NewsStore.newsData');

  @override
  List<NewsModel> get newsData {
    _$newsDataAtom.reportRead();
    return super.newsData;
  }

  @override
  set newsData(List<NewsModel> value) {
    _$newsDataAtom.reportWrite(value, super.newsData, () {
      super.newsData = value;
    });
  }

  final _$getNewsDataAsyncAction = AsyncAction('_NewsStore.getNewsData');

  @override
  Future<dynamic> getNewsData({bool refresh = false}) {
    return _$getNewsDataAsyncAction
        .run(() => super.getNewsData(refresh: refresh));
  }

  @override
  String toString() {
    return '''
loading: ${loading},
newsData: ${newsData}
    ''';
  }
}
