import 'package:mobx/mobx.dart';

part 'store.g.dart';

class ViewStore = _ViewStoreBase with _$ViewStore;

abstract class _ViewStoreBase with Store {
  @observable
  int currentPage = 0;

  // ignore: use_setters_to_change_properties
  @action
  void setPage(int page) {
    currentPage = page;
  }
}
