import 'dart:async';

import 'package:aoli/utils/http_request.dart';

/// 咨询内容详情请求服务
class NewsContentService extends BasicHttpService {
  /// 咨询ID
  final String id;

  NewsContentService({this.id});

  HttpRequest get request {
    return HttpRequest<NewsContentData>('/article/articleInfo',
        method: RequestMethod.POST, transform: (json) {
      return NewsContentData.fromJson(json);
    });
  }

  Future<NewsContentData> send() async {
    Map<String, dynamic> data = {
      'id': id,
    };
    return request.send(data: data);
  }
}

class NewsContentData {
  String id;
  String title;
  String thumb;
  String likecount;
  String content;
  String pdfurl;
  int isfollow;
  int islike;

  NewsContentData(
      {this.id,
      this.title,
      this.thumb,
      this.likecount,
      this.content,
      this.pdfurl,
      this.isfollow,
      this.islike});

  NewsContentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumb = json['thumb'];
    likecount = json['likecount'];
    content = json['content'];
    pdfurl = json['pdfurl'];
    isfollow = json['isfollow'];
    islike = json['islike'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['thumb'] = this.thumb;
    data['likecount'] = this.likecount;
    data['content'] = this.content;
    data['pdfurl'] = this.pdfurl;
    data['isfollow'] = this.isfollow;
    data['islike'] = this.islike;
    return data;
  }
}
