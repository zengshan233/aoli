import 'package:mobx/mobx.dart';

part 'research_store.g.dart';

/// 消息@ store
class RearchStore extends _RearchStore with _$RearchStore {
  static RearchStore _instance;
  factory RearchStore() => _instance ??= RearchStore._();
  RearchStore._() : super();
}

abstract class _RearchStore with Store {
  String keyWords;

  // @observaba
  // ResearchType researchType;

  // @action


}
