import 'dart:async';

import 'package:aoli/utils/http_request.dart';

class NewsType {
  const NewsType._(this.index);

  final index;

  static const NewsType news = NewsType._(0);

  static const NewsType research = NewsType._(1);

  static const NewsType fund = NewsType._(2);

  static const List<int> _methods = <int>[1, 2, 3];

  @override
  String toString() {
    return _methods[index].toString();
  }
}

/// 咨询列表请求服务
class NewsService extends BasicHttpService {
  /// 起始时间
  final String startdate;

  /// 结束时间
  final String enddate;

  /// 文章类型
  final NewsType type;

  NewsService({this.startdate, this.enddate, this.type});

  HttpRequest get request {
    return HttpRequest<NewsResponse>('/article/articleList',
        method: RequestMethod.POST, transform: (json) {
      return NewsResponse.fromJson(json);
    });
  }

  Future<NewsResponse> send() async {
    Map<String, dynamic> data = {
      'startdate': startdate ?? '',
      'enddate': enddate ?? '',
      'articletype': type.toString()
    };
    return request.send(data: data);
  }
}

class NewsFollowService extends BasicHttpService {
  /// 起始时间
  final String id;

  /// 结束时间
  final int status;

  /// 文章类型
  final NewsType type;

  NewsFollowService({this.id, this.status, this.type});

  HttpRequest get request {
    return HttpRequest<NewsResponse>('/app/article/articleCollect',
        method: RequestMethod.POST, transform: (json) {
      return null;
    });
  }

  Future send() async {
    Map<String, dynamic> data = {
      'status': status.toString() ?? '',
      'objectid': id ?? '',
      'objecttype': type.toString()
    };
    return request.send(data: data);
  }
}

class NewsServisce extends BasicHttpService {
  /// 起始时间
  final String startdate;

  /// 结束时间
  final String enddate;

  /// 文章类型
  final NewsType type;

  NewsServisce({this.startdate, this.enddate, this.type});

  HttpRequest get request {
    return HttpRequest<NewsResponse>('/article/articleList',
        method: RequestMethod.POST, transform: (json) {
      return NewsResponse.fromJson(json);
    });
  }

  Future<NewsResponse> send() async {
    Map<String, dynamic> data = {
      'startdate': startdate ?? '',
      'enddate': enddate ?? '',
      'articletype': type.toString()
    };
    return request.send(data: data);
  }
}

class NewsResponse {
  List<NewsData> list;
  int total;

  NewsResponse({this.list, this.total});

  NewsResponse.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = new List<NewsData>();
      json['list'].forEach((v) {
        list.add(new NewsData.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class NewsData {
  String id;
  String title;
  String abstract;
  String thumb;
  String content;
  String createtime;
  int isfollow;
  int islike;

  NewsData(
      {this.id,
      this.title,
      this.abstract,
      this.thumb,
      this.content,
      this.createtime,
      this.isfollow,
      this.islike});

  NewsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    abstract = json['abstract'];
    thumb = json['thumb'];
    content = json['content'];
    createtime = json['createtime'];
    isfollow = json['isfollow'];
    islike = json['islike'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['abstract'] = this.abstract;
    data['thumb'] = this.thumb;
    data['content'] = this.content;
    data['createtime'] = this.createtime;
    data['isfollow'] = this.isfollow;
    data['islike'] = this.islike;
    return data;
  }
}