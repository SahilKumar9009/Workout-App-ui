import 'package:flutter/material.dart';

// Step 1: Define the Workout model with a const constructor
class Workout {
  final String name;
  final String description;
  final String image;

  const Workout({
    required this.name,
    required this.description,
    required this.image,
  });
}

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  // Step 2: Replace List<String> with List<Workout>
  final List<Workout> workouts = const [
    Workout(
      name: 'Push Day',
      description: 'Push-ups, bench press, shoulder press',
      image:
          'https://images.unsplash.com/photo-1571388072750-31a921b3d900?auto=format&fit=crop&q=80&w=1325',
    ),
    Workout(
      name: 'Pull Day',
      description: 'Pull-ups, deadlift, row',
      image:
          'https://images.unsplash.com/photo-1571388072750-31a921b3d900?auto=format&fit=crop&q=80&w=1325',
    ),
    Workout(
      name: 'Leg Day',
      description: 'Squats, lunges, leg press',
      image:
          'https://images.unsplash.com/photo-1571388072750-31a921b3d900?auto=format&fit=crop&q=80&w=1325',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workouts')),
      body: ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          final workout = workouts[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(
                workout.image,
                width: 50,
                fit: BoxFit.cover,
              ),
              title: Text(workout.name),
              subtitle: Text(workout.description),
            ),
          );
        },
      ),
    );
  }
}
