import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workout_app/helpers/Validators.dart';

final counterProvider = StateProvider<int>((ref) => 0);
final switchValue = StateProvider<bool>((ref) => false);
final profileImageProvider = StateProvider<File?>((ref) => null);
final nameProvider = StateProvider<String>((ref) => '');
final emailProvider = StateProvider<String>((ref) => '');
final phoneProvider = StateProvider<String>((ref) => '');

// Optional greeting provider
final hello = Provider<String>((ref) => "hello riverpod");

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  bool _autoValidate = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: ref.read(nameProvider));
    _emailController = TextEditingController(text: ref.read(emailProvider));
    _phoneController = TextEditingController(text: ref.read(phoneProvider));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
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

  Future<void> _saveProfile() async {
    // Enable validation
    setState(() => _autoValidate = true);

    // Validate form
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fix the errors before saving'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Show loading
    setState(() => _isSubmitting = true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Save form
      _formKey.currentState!.save();

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final count = ref.watch(counterProvider);
    final greeting = ref.watch(hello);
    final isSwitched = ref.watch(switchValue);
    final profileImage = ref.watch(profileImageProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidate
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
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
                              color: Colors.white,
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Name field with validation
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Enter your full name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
                controller: _nameController,
                validator: Validators.name,
                textCapitalization: TextCapitalization.words,
                onChanged: (value) {
                  ref.read(nameProvider.notifier).state = value;
                },
                onSaved: (value) {
                  ref.read(nameProvider.notifier).state = value ?? '';
                },
              ),
              const SizedBox(height: 20),

              // Email field with validation
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "your.email@example.com",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: Validators.email,
                onChanged: (value) {
                  ref.read(emailProvider.notifier).state = value;
                },
                onSaved: (value) {
                  ref.read(emailProvider.notifier).state = value ?? '';
                },
              ),
              const SizedBox(height: 20),

              // Phone number field with validation
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  hintText: "Enter 10-digit mobile number",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone_outlined),
                  prefixText: "+91 ",
                ),
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                validator: Validators.phoneNumber,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                onChanged: (value) {
                  ref.read(phoneProvider.notifier).state = value;
                },
                onSaved: (value) {
                  ref.read(phoneProvider.notifier).state = value ?? '';
                },
              ),
              const SizedBox(height: 30),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _isSubmitting ? null : _saveProfile,
                  icon: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Icon(Icons.save),
                  label: Text(_isSubmitting ? 'Saving...' : 'Save Profile'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
