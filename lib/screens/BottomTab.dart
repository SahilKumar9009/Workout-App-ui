import 'package:flutter/material.dart';
import 'package:workout_app/screens/Home.dart';
import 'package:workout_app/screens/ProfileScreen.dart';

class BottomTabExample extends StatefulWidget {
  const BottomTabExample({super.key});

  @override
  State<BottomTabExample> createState() => _BottomTabExampleState();
}

class _BottomTabExampleState extends State<BottomTabExample> {
  int _currentIndex = 0; 


final List<Widget> _pages = [
  const HomeScreen(),
  const ProfileScreen(), 
  const Center(child: Text('Profile Page')), 
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}