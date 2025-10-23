import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailS extends StatelessWidget {
  final String workoutName;

  DetailS({super.key, required this.workoutName});

  // 🔴 PUSH DAY DATA
  final List<Map<String, String>> pushDayExercises = [
    {
      'name': 'Barbell Bench Press',
      'muscle': 'Chest',
      'setsReps': '4×6–8',
      'videoUrl': 'https://youtube.com/shorts/Kp9axtTvvYA?si=aA7oHl32tH5tiE_0',
    },
    {
      'name': 'Incline Dumbbell Press',
      'muscle': 'Chest',
      'setsReps': '3×8–10',
      'videoUrl': 'https://youtube.com/shorts/ou6s32mJgjU?si=I99DZaOnPdEGIlTM',
    },
    {
      'name': 'Chest Dips',
      'muscle': 'Chest / Triceps',
      'setsReps': '3 sets to failure',
      'videoUrl': 'https://youtube.com/shorts/5k7Atrwsty0?si=-89H2eQVBqypojUZ',
    },
    {
      'name': 'Cable Flys',
      'muscle': 'Chest',
      'setsReps': '3×12–15',
      'videoUrl': 'https://youtube.com/shorts/9SbRq-KmGsg?si=jRf3hTbmE2JLUVo1',
    },
    {
      'name': 'Overhead Barbell Press (OHP)',
      'muscle': 'Shoulders',
      'setsReps': '4×6–8',
      'videoUrl': 'https://youtube.com/shorts/9SbRq-KmGsg?si=jRf3hTbmE2JLUVo1',
    },
    {
      'name': 'Lateral Raises',
      'muscle': 'Shoulders',
      'setsReps': '3×12–15',
      'videoUrl': 'https://youtube.com/shorts/9SbRq-KmGsg?si=jRf3hTbmE2JLUVo1',
    },
    {
      'name': 'Rear Delt Flys',
      'muscle': 'Shoulders',
      'setsReps': '3×12–15',
      'videoUrl': 'https://youtube.com/shorts/9SbRq-KmGsg?si=jRf3hTbmE2JLUVo1',
    },
    {
      'name': 'Close-Grip Bench Press',
      'muscle': 'Triceps',
      'setsReps': '3×8–10',
      'videoUrl': 'https://youtube.com/shorts/9SbRq-KmGsg?si=jRf3hTbmE2JLUVo1',
    },
    {
      'name': 'Overhead Tricep Extension',
      'muscle': 'Triceps',
      'setsReps': '3×10–12',
      'videoUrl': 'https://youtube.com/shorts/9SbRq-KmGsg?si=jRf3hTbmE2JLUVo1',
    },
    {
      'name': 'Tricep Pushdowns',
      'muscle': 'Triceps',
      'setsReps': '3×12–15',
      'videoUrl': 'https://youtube.com/shorts/9SbRq-KmGsg?si=jRf3hTbmE2JLUVo1',
    },
  ];

  // 🟢 PULL DAY DATA
  final List<Map<String, String>> pullDayExercises = [
    {
      'name': 'Deadlift',
      'muscle': 'Back / Hamstrings',
      'setsReps': '4×5',
      'videoUrl': 'https://youtube.com/shorts/example1',
    },
    {
      'name': 'Pull-Ups',
      'muscle': 'Lats / Biceps',
      'setsReps': '3 sets to failure',
      'videoUrl': 'https://youtube.com/shorts/example2',
    },
    {
      'name': 'Barbell Rows',
      'muscle': 'Back',
      'setsReps': '4×8',
      'videoUrl': 'https://youtube.com/shorts/example3',
    },
    {
      'name': 'Seated Cable Rows',
      'muscle': 'Back',
      'setsReps': '3×10–12',
      'videoUrl': 'https://youtube.com/shorts/example4',
    },
    {
      'name': 'Face Pulls',
      'muscle': 'Rear Delts',
      'setsReps': '3×12–15',
      'videoUrl': 'https://youtube.com/shorts/example5',
    },
    {
      'name': 'Lat Pulldown',
      'muscle': 'Lats',
      'setsReps': '3×10–12',
      'videoUrl': 'https://youtube.com/shorts/example6',
    },
    {
      'name': 'Barbell Curls',
      'muscle': 'Biceps',
      'setsReps': '3×10–12',
      'videoUrl': 'https://youtube.com/shorts/example7',
    },
    {
      'name': 'Hammer Curls',
      'muscle': 'Biceps / Forearms',
      'setsReps': '3×12',
      'videoUrl': 'https://youtube.com/shorts/example8',
    },
  ];

  // 🟡 LEG DAY DATA
  final List<Map<String, String>> legDayExercises = [
    {
      'name': 'Barbell Squat',
      'muscle': 'Quads / Glutes',
      'setsReps': '4×6–8',
      'videoUrl': 'https://youtube.com/shorts/example9',
    },
    {
      'name': 'Romanian Deadlift',
      'muscle': 'Hamstrings / Glutes',
      'setsReps': '4×8',
      'videoUrl': 'https://youtube.com/shorts/example10',
    },
    {
      'name': 'Leg Press',
      'muscle': 'Quads / Glutes',
      'setsReps': '3×10–12',
      'videoUrl': 'https://youtube.com/shorts/example11',
    },
    {
      'name': 'Lunges',
      'muscle': 'Quads / Glutes',
      'setsReps': '3×12 per leg',
      'videoUrl': 'https://youtube.com/shorts/example12',
    },
    {
      'name': 'Leg Extensions',
      'muscle': 'Quads',
      'setsReps': '3×15',
      'videoUrl': 'https://youtube.com/shorts/example13',
    },
    {
      'name': 'Leg Curls',
      'muscle': 'Hamstrings',
      'setsReps': '3×15',
      'videoUrl': 'https://youtube.com/shorts/example14',
    },
    {
      'name': 'Standing Calf Raises',
      'muscle': 'Calves',
      'setsReps': '4×15–20',
      'videoUrl': 'https://youtube.com/shorts/example15',
    },
    {
      'name': 'Seated Calf Raises',
      'muscle': 'Calves',
      'setsReps': '3×15–20',
      'videoUrl': 'https://youtube.com/shorts/example16',
    },
  ];

  // 🧠 Choose exercises based on workout name
  List<Map<String, String>> _getExercises() {
    switch (workoutName.toLowerCase()) {
      case 'push day':
        return pushDayExercises;
      case 'pull day':
        return pullDayExercises;
      case 'leg day':
        return legDayExercises;
      default:
        return [];
    }
  }

  // 🔗 Open video URL
  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final exercises = _getExercises();

    return Scaffold(
      appBar: AppBar(
        title: Text(workoutName, style: const TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF141414),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: exercises.isEmpty
          ? const Center(child: Text('No exercises found'))
          : ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                final videoId = YoutubePlayer.convertUrlToId(
                  exercise['videoUrl']!,
                );

                YoutubePlayerController? _controller;
                if (videoId != null) {
                  _controller = YoutubePlayerController(
                    initialVideoId: videoId,
                    flags: const YoutubePlayerFlags(
                      autoPlay: false,
                      mute: false,
                    ),
                  );
                }

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 1}. ${exercise['name']}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${exercise['muscle']} • ${exercise['setsReps']}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        if (_controller != null)
                          YoutubePlayer(
                            controller: _controller,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colors.red,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
