import 'package:flutter/material.dart';
import 'package:workout_app/screens/Login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const  ProviderScope(child: WorkoutApp()));
}

class WorkoutApp extends StatelessWidget {
  const WorkoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Workout App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  LoginScreen(),
    );
  }
}

