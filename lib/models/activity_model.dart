class Activity {
  final String id;
  final String name;
  int count;

  Activity({required this.id, required this.name, required this.count});

  Activity copyWith({String? id, String? name, int? count}) {
    return Activity(
      id: id ?? this.id,
      name: name ?? this.name,
      count: count ?? this.count,
    );
  }
}
