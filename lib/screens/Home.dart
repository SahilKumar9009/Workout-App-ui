import 'package:flutter/material.dart';
import 'package:workout_app/screens/Detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, String>> workouts = const [
    {
      'name': 'Push Day',
      'type': 'Strength',
      'image':
          'https://res.cloudinary.com/grow-me/v1709317312/uhg6emdo8ynecxo9ho0m.jpg',
    },
    {
      'name': 'Pull Day',
      'type': 'Strength',
      'image':
          'https://www.gymshark.com/_next/image?url=https%3A%2F%2Fimages.ctfassets.net%2F8urtyqugdt2l%2F3KKaDRAdnygxfXztrvxlk2%2F503ff00aa94782984d7134197e2c4793%2Fdesktop-best-row-exercises.jpg&w=3840&q=85',
    },
    {
      'name': 'Leg Day',
      'type': 'Strength',
      'image':
          'https://hips.hearstapps.com/hmg-prod/images/side-lunge-1543424933.jpg?crop=0.431xw:0.648xh;0.216xw,0.352xh',
    },
    {
      'name': 'Cardio Blast',
      'type': 'Cardio',
      'image':
          'https://hips.hearstapps.com/hmg-prod/images/workouts/2016/03/jumpingjack-1457045563.gif?crop=1xw:0.75xh;center,top&resize=1200:*',
    },
    {
      'name': 'Yoga Flow',
      'type': 'Flexibility',
      'image':
          'https://media.hearstapps.com/loop/downward-facing-dog-1588797297.mp4/poster.jpg',
    },
    {
      'name': 'HIIT Session',
      'type': 'Cardio',
      'image':
          'https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExNmR1anR3OWZ3cDVraXR0bmp1dXN2bzAwN3BlazdoaHU1ZTlkYWQ3YiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/lvDeTIzaGXHWZ5l8sP/giphy.gif',
    },
    {
      'name': 'Full Body',
      'type': 'Strength',
      'image':
          'https://images.unsplash.com/photo-1599058917210-c2a497fa8913?fit=crop&w=400&q=80',
    },
    {
      'name': 'Stretching',
      'type': 'Flexibility',
      'image':
          'https://images.unsplash.com/photo-1594737625785-33d9f0da1f07?fit=crop&w=400&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Workout App', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF141414),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white, // Set back button color here
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Discover',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                  final workout = workouts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          workout['image']!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.fitness_center,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                      title: Text(
                        workout['name']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(workout['type']!),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkoutDetailScreen(
                              workoutName: workout['name']!,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
