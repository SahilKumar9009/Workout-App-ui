import 'package:flutter/material.dart';
import 'package:workout_app/screens/Detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<String> workouts = const [
    'Push Day',
    'Pull Day',
    'Leg Day',
    'Push Day',
    'Pull Day',
    'Leg Day',
    'Push Day',
    'Pull Day',
    'Leg Day',
    'Push Day',
    'Pull Day',
    'Leg Day',
    'Push Day',
    'Pull Day',
    'Leg Day',
    'Push Day',
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
                    builder: (context) => WorkoutDetailScreen(
                      workoutName: workouts[index],
                    ),
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