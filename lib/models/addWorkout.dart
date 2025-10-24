class AddWorkout {
  final String name;
  final String muscle;

  AddWorkout({required this.name, required this.muscle});

  // Convert a Workout object to a Map (for JSON encoding/saving)
  Map<String, dynamic> toJson() => {'name': name, 'muscle': muscle};

  // Create a Workout object from a Map (for JSON decoding/loading)
  factory AddWorkout.fromJson(Map<String, dynamic> json) {
    return AddWorkout(
      name: json['name'] as String,
      muscle: json['muscle'] as String,
    );
  }
}
