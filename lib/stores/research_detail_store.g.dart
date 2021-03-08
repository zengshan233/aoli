// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'research_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ResearchDetailStore on _ResearchDetailStore, Store {
  final _$loadingAtom = Atom(name: '_ResearchDetailStore.loading');

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

  final _$isfollowAtom = Atom(name: '_ResearchDetailStore.isfollow');

  @override
  bool get isfollow {
    _$isfollowAtom.reportRead();
    return super.isfollow;
  }

  @override
  set isfollow(bool value) {
    _$isfollowAtom.reportWrite(value, super.isfollow, () {
      super.isfollow = value;
    });
  }

  final _$isLikeAtom = Atom(name: '_ResearchDetailStore.isLike');

  @override
  bool get isLike {
    _$isLikeAtom.reportRead();
    return super.isLike;
  }

  @override
  set isLike(bool value) {
    _$isLikeAtom.reportWrite(value, super.isLike, () {
      super.isLike = value;
    });
  }

  final _$detailDataAtom = Atom(name: '_ResearchDetailStore.detailData');

  @override
  NewsContentData get detailData {
    _$detailDataAtom.reportRead();
    return super.detailData;
  }

  @override
  set detailData(NewsContentData value) {
    _$detailDataAtom.reportWrite(value, super.detailData, () {
      super.detailData = value;
    });
  }

  final _$progressAtom = Atom(name: '_ResearchDetailStore.progress');

  @override
  int get progress {
    _$progressAtom.reportRead();
    return super.progress;
  }

  @override
  set progress(int value) {
    _$progressAtom.reportWrite(value, super.progress, () {
      super.progress = value;
    });
  }

  final _$taskStatusAtom = Atom(name: '_ResearchDetailStore.taskStatus');

  @override
  int get taskStatus {
    _$taskStatusAtom.reportRead();
    return super.taskStatus;
  }

  @override
  set taskStatus(int value) {
    _$taskStatusAtom.reportWrite(value, super.taskStatus, () {
      super.taskStatus = value;
    });
  }

  final _$initStatusAsyncAction =
      AsyncAction('_ResearchDetailStore.initStatus');

  @override
  Future initStatus() {
    return _$initStatusAsyncAction.run(() => super.initStatus());
  }

  final _$getDetailAsyncAction = AsyncAction('_ResearchDetailStore.getDetail');

  @override
  Future<dynamic> getDetail(String id, {bool refresh = false}) {
    return _$getDetailAsyncAction
        .run(() => super.getDetail(id, refresh: refresh));
  }

  final _$followAsyncAction = AsyncAction('_ResearchDetailStore.follow');

  @override
  Future follow() {
    return _$followAsyncAction.run(() => super.follow());
  }

  final _$downloadAsyncAction = AsyncAction('_ResearchDetailStore.download');

  @override
  Future<dynamic> download() {
    return _$downloadAsyncAction.run(() => super.download());
  }

  final _$_ResearchDetailStoreActionController =
      ActionController(name: '_ResearchDetailStore');

  @override
  dynamic updateDownload(int progressIndex, int sunProgress) {
    final _$actionInfo = _$_ResearchDetailStoreActionController.startAction(
        name: '_ResearchDetailStore.updateDownload');
    try {
      return super.updateDownload(progressIndex, sunProgress);
    } finally {
      _$_ResearchDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic resetState() {
    final _$actionInfo = _$_ResearchDetailStoreActionController.startAction(
        name: '_ResearchDetailStore.resetState');
    try {
      return super.resetState();
    } finally {
      _$_ResearchDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
isfollow: ${isfollow},
isLike: ${isLike},
detailData: ${detailData},
progress: ${progress},
taskStatus: ${taskStatus}
    ''';
  }
}
