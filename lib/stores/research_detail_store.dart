import 'dart:io';

import 'package:aoli/services/news_content_service.dart';
import 'package:aoli/services/news_service.dart';
import 'package:aoli/utils/ToastUtils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:mobx/mobx.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

part 'research_detail_store.g.dart';

const int DOWNLOAD_SUCCESS = 0;
const int DOWNLOAD_PROGRESS = 10;
const int DOWNLOAD_CANCELED = 20;

/// 注册 store
class ResearchDetailStore extends _ResearchDetailStore
    with _$ResearchDetailStore {
  static ResearchDetailStore _instance;
  factory ResearchDetailStore() => _instance ??= ResearchDetailStore._();
  ResearchDetailStore._() : super();
}

abstract class _ResearchDetailStore with Store {
  @observable
  bool loading;

  @observable
  bool isfollow;

  @observable
  bool isLike;

  @observable
  NewsContentData detailData;

  @observable
  int progress;

  @observable
  int taskStatus = -1;

  String taskId;

  String taskPath;

  @action
  initStatus() async {
    String fileName = detailData.pdfurl.split('/').last;
    Directory tempDir = await getTemporaryDirectory();
    String savePath = tempDir.path + "/" + fileName;
    File file = File(savePath);
    bool exist = await file.exists();
    taskStatus = exist ? DOWNLOAD_SUCCESS : -1;
  }

  @action
  Future getDetail(String id, {bool refresh = false}) async {
    if (!refresh) {
      loading = true;
    }
    NewsContentData data;
    try {
      data = await NewsContentService(id: id).send();
    } catch (e) {
      print('getNewsData error $e');
      loading = false;
      return;
    }
    loading = false;
    detailData = data;
    if (!refresh) {
      initStatus();
    }
  }

  @action
  follow() async {
    try {
      await NewsFollowService(
              id: detailData.id,
              status: detailData.isfollow == 1 ? 0 : 1,
              type: NewsType.research)
          .send();
      await getDetail(detailData.id,refresh:  true);
    } catch (e) {
      print('getNewsData error $e');
      loading = false;
      return;
    }
  }

  @action
  Future download() async {
    if (taskStatus != DOWNLOAD_PROGRESS) {
      String fileName = detailData.pdfurl.split('/').last;
      Directory tempDir = await getTemporaryDirectory();
      String savePath = tempDir.path + "/" + fileName;
      File file = File(savePath);
      bool exist = await file.exists();
      if (!exist) {
        File file = await getNewTemporaryFile(fileName: fileName);
        taskPath = file.path;
        await Dio().download(detailData.pdfurl, file.path,
            onReceiveProgress: (progressIndex, sunProgress) =>
                updateDownload(progressIndex, sunProgress));
      } else {
        OpenFile.open(taskPath);
      }
    }
  }

  Future<File> getNewTemporaryFile(
      {String fileName, bool create = false}) async {
    Directory tempDir = await getTemporaryDirectory();
    String savePath = tempDir.path + "/" + fileName;
    File file = File(savePath);
    bool exist = await file.exists();
    if (create && !exist) {
      file.createSync();
    }
    return file;
  }

  @action
  updateDownload(
    int progressIndex,
    int sunProgress,
  ) {
    int _progress =
        (progressIndex / (sunProgress > 0 ? sunProgress : 1) * 100).toInt();
    _progress = _progress > 100 ? 100 : _progress;
    if (_progress > 0 && _progress < 100) {
      taskStatus = DOWNLOAD_PROGRESS;
      progress = _progress;
    } else {
      taskStatus = DOWNLOAD_SUCCESS;
    }
  }

  @action
  resetState() {
    taskStatus = null;
    progress = 0;
    detailData = null;
    taskId = null;
  }
}
