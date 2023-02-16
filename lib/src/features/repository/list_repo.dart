import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/list_model.dart';

final listRepoProvider = Provider<ListRepositoryInterface>((ref) {
  return ListRepository();
});

abstract class ListRepositoryInterface {
  addItem(ListModel model);
  removeItem(ListModel model);
  List<ListModel> getAllItems();
  clearAllItems();
  List<ListModel> getActiveItems();
  getCompletedItems();
}

class ListRepository implements ListRepositoryInterface {
  @override
  addItem(ListModel model) {
    getActiveItems().add(model);
  }

  @override
  clearAllItems() {
    getActiveItems().clear();
  }

  @override
  getActiveItems() {
    return getAllItems().where((element) => element.isActive == true).toList();
  }

  @override
  getAllItems() {
    return [];
  }

  @override
  getCompletedItems() {
    return getAllItems().where((element) => element.isActive != true).toList();
  }

  @override
  removeItem(ListModel model) {
    return getActiveItems().remove(model);
  }
}
