import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/Providers/workoutProvider.dart';
import 'package:workout_app/models/addWorkout.dart';

class AddWorkoutScreen extends ConsumerStatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  ConsumerState<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends ConsumerState<AddWorkoutScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _muscleController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _muscleController.dispose();
    super.dispose();
  }

  void _addWorkout() {
    final name = _nameController.text.trim();
    final muscle = _muscleController.text.trim();

    if (name.isEmpty || muscle.isEmpty) return;

    // Add to Riverpod state (will automatically save to storage)
    ref
        .read(workoutProvider.notifier)
        .addWorkout(AddWorkout(name: name, muscle: muscle));

    _nameController.clear();
    _muscleController.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // Watch the workout list from Riverpod
    final workouts = ref.watch(workoutProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Tasks', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF141414),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Workout Name',
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _muscleController,
                              decoration: const InputDecoration(
                                labelText: 'Muscle Name',
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF141414),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: _addWorkout,
                              child: const Text(
                                'Add Workout',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Text(
                  'Add Workout Plan',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF141414),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: workouts.isEmpty
                ? const Center(child: Text('No workouts added yet'))
                : ListView.builder(
                    itemCount: workouts.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.fitness_center),
                        title: Text(workouts[index].name),
                        subtitle: Text(workouts[index].muscle),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            ref
                                .read(workoutProvider.notifier)
                                .removeWorkout(index);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
