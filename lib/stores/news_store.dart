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

  @observable
  bool loading;

  // @action


}
