import 'package:flutter/foundation.dart';
import '../models/activity_model.dart';
import '../repositories/activity_repository.dart';

class ActivityViewModel extends ChangeNotifier {
  final ActivityRepository _repo = ActivityRepository();
  List<Activity> _activities = [];

  ActivityViewModel() {
    _load();
  }

  List<Activity> get activities => List.unmodifiable(_activities);

  void _load() {
    _activities = _repo.getAll();
    notifyListeners();
  }

  // CRUD operations
  void addActivity(String name, int count) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final act = Activity(id: id, name: name, count: count);
    _repo.add(act);
    _load();
  }

  void updateActivity(String id, String name, int count) {
    final updated = Activity(id: id, name: name, count: count);
    _repo.update(updated);
    _load();
  }

  void deleteActivity(String id) {
    _repo.delete(id);
    _load();
  }

  void increment(String id) {
    _repo.increment(id);
    _load();
  }

  void decrement(String id) {
    _repo.decrement(id);
    _load();
  }

  void reset(String id) {
    _repo.reset(id);
    _load();
  }
}
