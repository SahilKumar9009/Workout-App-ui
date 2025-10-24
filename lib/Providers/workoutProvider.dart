import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/models/addWorkout.dart';

class WorkoutNotifier extends Notifier<List<AddWorkout>> {
  static const String _storageKey = 'workouts_list';

  @override
  List<AddWorkout> build() {
    // Load workouts when the notifier is first created
    _loadWorkouts();
    return [];
  }

  Future<void> _loadWorkouts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? workoutsJson = prefs.getString(_storageKey);

    if (workoutsJson != null) {
      final List<dynamic> decoded = jsonDecode(workoutsJson);
      state = decoded.map((json) => AddWorkout.fromJson(json)).toList();
    }
  }

  // Save workouts to SharedPreferences
  Future<void> _saveWorkouts() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(
      state.map((workout) => workout.toJson()).toList(),
    );
    await prefs.setString(_storageKey, encoded);
  }

  // Add a new workout
  void addWorkout(AddWorkout workout) {
    state = [...state, workout];
    _saveWorkouts();
  }

  // Remove a workout by index
  void removeWorkout(int index) {
    state = [...state]..removeAt(index);
    _saveWorkouts();
  }

  // Update a workout at specific index
  void updateWorkout(int index, AddWorkout workout) {
    final newList = [...state];
    newList[index] = workout;
    state = newList;
    _saveWorkouts();
  }

  // Clear all workouts
  void clearAll() {
    state = [];
    _saveWorkouts();
  }
}

// Provider definition
final workoutProvider = NotifierProvider<WorkoutNotifier, List<AddWorkout>>(() {
  return WorkoutNotifier();
});
