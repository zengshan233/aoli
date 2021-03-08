import 'package:aoli/model/news_model.dart';
import 'package:aoli/services/news_service.dart';
import 'package:aoli/utils/date_util.dart';
import 'package:mobx/mobx.dart';

part 'news_store.g.dart';

/// 消息@ store
class NewsStore extends _NewsStore with _$NewsStore {
  static NewsStore _instance;
  factory NewsStore() => _instance ??= NewsStore._();
  NewsStore._() : super();
}

abstract class _NewsStore with Store {
  String keyWords;

  int _count = 1;

  @observable
  bool loading = false;

  @observable
  List<NewsModel> newsData;

  @action
  Future getNewsData({bool refresh = false}) async {
    if (!refresh) {
      loading = true;
    }
    List<NewsModel> _newsData = [];
    Map<String, List<NewsData>> newsMap = {};
    NewsResponse data;
    try {
      data = await NewsService(type: NewsType.news).send();
    } catch (e) {
      print('getNewsData error $e');
      loading = false;
      return;
    }
    data.list.forEach((e) {
      String date = e.createtime.split(' ').first.replaceAll('-', '/');
      newsMap[date] ??= [];
      newsMap[date].add(e);
    });
    List<String> weekList = _calWeek(newsMap.keys.toList());
    weekList.forEach((w) {
      NewsModel _news = w == '-'
          ? null
          : NewsModel(
              date: w,
              news: newsMap[w]
                  .map((n) => NewsInfo(title: n.title, content: n.content))
                  .toList());
      _newsData.add(_news);
    });
    newsData = _newsData;
    loading = false;
    print('newsData $newsData');
  }

  List<String> _calWeek(List<String> list) {
    List<String> _resultList = [];
    // list.rede
    String resultString = list.reduce((a, b) {
      String previous =
          a.replaceAll('+', ' ').replaceAll('-', ' ').split(' ').last;
      String result;
      int millSecondsA = DateUtil.getDateTime(previous).millisecondsSinceEpoch;
      int millSecondsB = DateUtil.getDateTime(b).millisecondsSinceEpoch;
      int weekA = DateUtil.getDateTime(previous).weekday;
      int weekB = DateUtil.getDateTime(b).weekday;
      double day = (millSecondsA - millSecondsB) / 1000 / 60 / 60 / 24;
      if (weekA > weekB && day <= 6) {
        result = '$a+$b';
      } else {
        result = '$a-$b';
      }
      return result;
    });
    List<String> splitResult = resultString.split('+');
    splitResult.forEach((r) {
      if (r.contains('-')) {
        List<String> weekSplit = r.split('-');
        _resultList.addAll([weekSplit.first, '-', weekSplit.last]);
      } else {
        _resultList.add(r);
      }
    });
    return _resultList;
  }
}
