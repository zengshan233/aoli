

class NewsModel {
  final String date;
  final List<NewsInfo> news;
  NewsModel({this.date, this.news});
}

class NewsInfo {
  final String title;
  final String content;
  NewsInfo({this.title, this.content});
}
