import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/list_model.dart';
import '../repository/list_repo.dart';

final listProvider = StateNotifierProvider((ref) {
  final repoSitoryProvider = ref.watch(listRepoProvider);
  return ListProvider([], repoSitoryProvider);
});

class ListProvider extends StateNotifier<List<ListModel>> {
  ListRepositoryInterface repository;
  ListProvider(super.state, this.repository);

  runInit() {
    getAllDreams();
    getActiveDreams();
    getCompletedDreams();
  }

  //all dreams list
  static List<ListModel> _allDreams = [];
  List<ListModel> get allDreams => _allDreams;

  //all active list
  static List<ListModel> _allActiveDreams = [];
  List<ListModel> get activeDreams => _allActiveDreams;

  //all completed list
  static List<ListModel> _allCompletedDreams = [];
  List<ListModel> get completedDreams => _allCompletedDreams;

  getAllDreams() {
    List<ListModel> allModelsfromRepository = repository.getAllItems();
    _allDreams = allModelsfromRepository;
  }

  getActiveDreams() {
    List<ListModel> allActiveModelsfromRepository = repository.getActiveItems();
    _allActiveDreams = allActiveModelsfromRepository;
  }

  getCompletedDreams() {
    List<ListModel> allCompletedRepository = repository.getCompletedItems();
    _allCompletedDreams = allCompletedRepository;
  }

  addItemToActive(ListModel listMOdelFromUI) {
    state = [..._allActiveDreams, listMOdelFromUI];

    _allCompletedDreams.remove(listMOdelFromUI);

    _allActiveDreams = state;

    _allDreams = _allActiveDreams + _allCompletedDreams;
  }

  addItemToCompleted(int index) {
    ListModel listModel =
        _allActiveDreams.elementAt(index).copyWith(isActive: false);
    state = [..._allActiveDreams];
    _allCompletedDreams.add(listModel);
    _allActiveDreams.removeAt(index);
    _allDreams = _allActiveDreams + _allCompletedDreams;
  }

  clearAllDreams() {
    _allDreams.clear();
    _allCompletedDreams.clear();
    _allActiveDreams.clear();
    state = [..._allActiveDreams, ..._allDreams];
  }
}
