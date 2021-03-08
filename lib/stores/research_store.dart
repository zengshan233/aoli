import 'package:aoli/model/research_model.dart';
import 'package:aoli/services/news_service.dart';
import 'package:mobx/mobx.dart';

part 'research_store.g.dart';

/// 消息@ store
class ResarchStore extends _ResarchStore with _$ResarchStore {
  static ResarchStore _instance;
  factory ResarchStore() => _instance ??= ResarchStore._();
  ResarchStore._() : super();
}

abstract class _ResarchStore with Store {
  String keyWords;

  @observable
  ResearchType researchType = ResearchType.comment;

  @observable
  List<NewsData> researchData;

  @observable
  bool loading;

  @action
  Future getResearchData({bool refresh = false}) async {
    if (!refresh) {
      loading = true;
    }

    NewsResponse data;
    try {
      data = await NewsService(type: NewsType.news).send();
    } catch (e) {
      print('getNewsData error $e');
      loading = false;
      return;
    }
    researchData = data.list;
    loading = false;
  }

  @action
  void changeTap(ResearchType type) {
    researchType = type;
    getResearchData();
  }
}
