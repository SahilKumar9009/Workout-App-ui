import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workout_app/helpers/Validators.dart';

// Providers
final counterProvider = StateProvider<int>((ref) => 0);
final switchValue = StateProvider<bool>((ref) => false);
final profileImageProvider = StateProvider<File?>((ref) => null);
final nameProvider = StateProvider<String>((ref) => '');
final emailProvider = StateProvider<String>((ref) => '');
final phoneProvider = StateProvider<String>((ref) => '');
final ageProvider = StateProvider<String>((ref) => '');

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: ref.read(nameProvider));
    _emailController = TextEditingController(text: ref.read(emailProvider));
    _phoneController = TextEditingController(text: ref.read(phoneProvider));
    _ageController = TextEditingController(text: ref.read(ageProvider));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    // Show dialog to choose between camera and gallery
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
            ],
          ),
        );
      },
    );

    if (source != null) {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        ref.read(profileImageProvider.notifier).state = File(pickedFile.path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final count = ref.watch(counterProvider);
    final isSwitched = ref.watch(switchValue);
    final profileImage = ref.watch(profileImageProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF141414),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white, // Set back button color here
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Circular Profile Image with tap to change
            GestureDetector(
              onTap: pickImage,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: profileImage != null
                        ? FileImage(profileImage)
                        : null,
                    child: profileImage == null
                        ? const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.black,
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Name field
            TextField(
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
              controller: _nameController,
              onChanged: (value) {
                ref.read(nameProvider.notifier).state = value;
              },
            ),
            const SizedBox(height: 20),

            // Email field
            TextField(
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_outlined),
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              onChanged: (value) {
                ref.read(emailProvider.notifier).state = value;
              },
            ),
            const SizedBox(height: 20),

            TextField(
              decoration: const InputDecoration(
                labelText: "Phone number",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone_outlined),
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _phoneController,
              onChanged: (value) {
                ref.read(phoneProvider.notifier).state = value;
              },
            ),
            const SizedBox(height: 20),

            TextField(
              decoration: const InputDecoration(
                labelText: "Age",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _ageController,
              onChanged: (value) {
                ref.read(ageProvider.notifier).state = value;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (ref.read(nameProvider.notifier).state.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Name is required',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                if (ref.read(emailProvider.notifier).state.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Email is required',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                if (ref.read(phoneProvider.notifier).state.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Phone number is required',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                if (ref.read(ageProvider.notifier).state.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Age is required',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF141414),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Save Changes',
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
