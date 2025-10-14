import 'package:flutter/material.dart';

void main() {
  runApp(const WorkoutApp());
}

class WorkoutApp extends StatelessWidget {
  const WorkoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

// Home Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<String> workouts = const [
    'Push Day',
    'Pull Day',
    'Leg Day',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout App')),
      body: ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(workouts[index]),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        WorkoutDetailScreen(workoutName: workouts[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Workout Detail Screen
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
