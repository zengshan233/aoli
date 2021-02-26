class NewsModel {
  final String title;
  final List<NewsData> news;
  NewsModel({this.title, this.news});
}

class NewsData {
  final String title;
  final String description;
  final String date;
  NewsData({this.title, this.description, this.date});
}
