import 'package:flutter/material.dart';
import 'package:workout_app/screens/Home.dart';
import 'package:workout_app/screens/ProfileScreen.dart';
import 'package:workout_app/screens/Workout.dart';

class BottomTabExample extends StatefulWidget {
  const BottomTabExample({super.key});

  @override
  State<BottomTabExample> createState() => _BottomTabExampleState();
}

class _BottomTabExampleState extends State<BottomTabExample> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const WorkoutScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        backgroundColor: const Color(0xFF141414),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center, color: Colors.white),
            label: 'Workout',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
