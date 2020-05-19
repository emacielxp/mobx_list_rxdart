import 'package:mobx/mobx.dart';
import 'package:mobxlist/models/item_model.dart';
import 'package:rxdart/rxdart.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final listItems = BehaviorSubject<List<ItemModel>>.seeded([]);
  final filter = BehaviorSubject<String>.seeded('');

  ObservableStream<List<ItemModel>> output;

  _HomeControllerBase() {
    output = Rx.combineLatest2<List<ItemModel>, String, List<ItemModel>>(listItems.stream, filter.stream, (list, filter) {
      if (filter.isEmpty) {
        return list;
      } else {
        return list.where((item) => item.title.toLowerCase().contains(filter.toLowerCase())).toList();
      }
    }).asObservable(initialValue: []);
  }

  @computed
  int get totalChecked => output.value.where((item) => item.check).length;

  @action
  setFilter(String value) => filter.add(value);

  @action
  addItem(ItemModel model) {
    var list = List<ItemModel>.from(listItems.value);
    list.add(model);
    listItems.add(list);
  }

  @action
  removeItem(ItemModel model) {
    var list = List<ItemModel>.from(listItems.value);
    list.removeWhere((item) => item.title == model.title);
    listItems.add(list);
  }
}