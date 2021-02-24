import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math';


DownloadCallback downloadCallBack(
    String id, DownloadTaskStatus status, int progress) {
  print('id $id');
  print('status $status');
  print('progress $progress');
}

//  'http://africau.edu/images/default/sample.pdf',

class PdfPage extends StatefulWidget {
  final String url;
  PdfPage({Key key, @required this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PdfPageState();
}

class PdfPageState extends State<PdfPage> {
  String taskId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future _downloadPdf() async {
    print('_downloadPdf');

    PermissionStatus permissionStatus =await NotificationPermissions.getNotificationPermissionStatus();
     print('permissionStatus $permissionStatus');
    NotificationPermissions.requestNotificationPermissions();
    Directory directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    String _localPath = directory.path + Platform.pathSeparator + 'Download';
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    taskId = await FlutterDownloader.enqueue(
      url: widget.url,
      savedDir: _localPath,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
    FlutterDownloader.registerCallback(downloadCallBack);
  }

  Future adownloadPdf() async {
    print('_downloadPdf');
    String dirloc = (await getApplicationDocumentsDirectory()).path;
    if (Platform.isAndroid) {
    } else {
      dirloc = (await getApplicationDocumentsDirectory()).path;
    }
    String savePath = dirloc + "/a.pdf";
    File file = File(savePath);
    bool exist = await file.exists();
    if (!exist) {
      file.createSync();
    }
    print('file.path ${file.path}');
    Dio().download(
      widget.url,
      file.path,
      // onReceiveProgress: downloadCallBack,
    );
  }

  Future downloadFile() async {
// PermissionStatus statuss = await Permission.notification.status;
    // print('status $statuss');
    // return ;
    Dio dio = Dio();
    String dirloc = "";
    if (Platform.isAndroid) {
      dirloc = "/sdcard/download/";
    } else {
      dirloc = (await getApplicationDocumentsDirectory()).path;
    }

    var randid = Random().nextInt(10000);

    try {
      FileUtils.mkdir([dirloc]);
      await dio.download(widget.url, dirloc + randid.toString() + ".pdf",
          onReceiveProgress: (receivedBytes, totalBytes) {
        String progress =
            ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
        print("progress $progress");
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cached PDF From Url'),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: const PDF().cachedFromUrl(
                widget.url,
                placeholder: (double progress) =>
                    Center(child: Text('$progress %')),
                errorWidget: (dynamic error) =>
                    Center(child: Text(error.toString())),
              ),
            ),
            Positioned(
                bottom: 100,
                child: TextButton(
                  onPressed: _downloadPdf,
                  child: Text('???'),
                )),
            Positioned(
                right: 0,
                bottom: 100,
                child: TextButton(
                  onPressed: () {
                    FlutterDownloader.open(taskId: taskId);
                  },
                  child: Text('open'),
                ))
          ],
        ));
  }
}
