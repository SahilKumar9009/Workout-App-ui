class Workout {
  final int id;
  final String name;
  final String description;
  final String image;

  Workout({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  // Convert from JSON Map (optional, useful if fetching from API)
  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description, 'image': image};
  }
}
