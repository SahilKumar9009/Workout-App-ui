import 'package:flutter/material.dart';

class WorkoutDetailScreen extends StatelessWidget {
  final String workoutName;
  const WorkoutDetailScreen({super.key, required this.workoutName});

  final Map<String, List<String>> exercises = const {
    'Push Day': ['Push-ups', 'Bench Press', 'Shoulder Press'],
    'Pull Day': ['Pull-ups', 'Deadlift', 'Rows'],
    'Leg Day': ['Squats', 'Lunges', 'Leg Press'],
  };

  @override
  Widget build(BuildContext context) {
    final List<String> workoutExercises = exercises[workoutName] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(workoutName)),
      body: ListView.builder(
        itemCount: workoutExercises.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.fitness_center),
            title: Text(workoutExercises[index]),
          );
        },
      ),
    );
  }
}
