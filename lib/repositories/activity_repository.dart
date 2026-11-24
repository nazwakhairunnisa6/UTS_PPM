import '../models/activity_model.dart';
import '../data/activity_data.dart';

class ActivityRepository {
  final List<Activity> _activities = List<Activity>.from(ActivityData.initialActivities);

  List<Activity> getAll() => List.unmodifiable(_activities);

  void add(Activity activity) => _activities.add(activity);

  void update(Activity updated) {
    final index = _activities.indexWhere((a) => a.id == updated.id);
    if (index != -1) {
      _activities[index] = updated;
    }
  }

  void delete(String id) => _activities.removeWhere((a) => a.id == id);

  void increment(String id) {
    final activity = _activities.firstWhere((a) => a.id == id);
    activity.count += 1;
  }

  void decrement(String id) {
    final activity = _activities.firstWhere((a) => a.id == id);
    if (activity.count > 0) activity.count -= 1;
  }

  void reset(String id) {
    final activity = _activities.firstWhere((a) => a.id == id);
    activity.count = 0;
  }
}
