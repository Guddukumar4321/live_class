import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme/app_theme.dart';
import 'bloc/setting_bloc.dart';
import 'bloc/setting_event.dart';
import 'bloc/setting_state.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingView> {
  final TextEditingController _passwordController = TextEditingController();
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().add(LoadUserProfile());
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) return;

      File tempImage = File(pickedFile.path);

      // Show dialog to crop/delete
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Preview & Edit"),
            content: SizedBox(
              height: 300,
              width: 300,
              child: Image.file(tempImage, fit: BoxFit.contain),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  setState(() {
                    _pickedImage = null;
                  });
                },
                child: const Text("Delete"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context); // Close dialog before crop
                  await _cropImage(tempImage.path);
                },
                child: const Text("Crop"),
              ),
              TextButton(
                onPressed: () {
                  final imageFile = File(tempImage.path);
                  context.read<SettingsBloc>().add(UpdateProfilePicture(imageFile));
                },
                child: const Text("Done"),
              ),
            ],
          );
        },
      );

      // Temporarily assign to preview in dialog
      setState(() {
        _pickedImage = tempImage;
      });
    } catch (e) {
      debugPrint('Image pick error: $e');
    }
  }


  Future<void> _cropImage(String imagePath) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePath,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 90,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.deepPurple,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(title: 'Crop Image'),
        ],
      );

      if (croppedFile != null) {
        final imageFile = File(croppedFile.path);
        setState(() {
          _pickedImage = imageFile;
        });
        context.read<SettingsBloc>().add(UpdateProfilePicture(imageFile));
      }
    } catch (e) {
      debugPrint('Image crop error: $e');
    }
  }


  void _showChangePasswordDialog() {
    _passwordController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Change Password"),
        content: TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(labelText: "New Password"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final newPassword = _passwordController.text.trim();
              if (newPassword.isNotEmpty) {
                context.read<SettingsBloc>().add(ChangePassword(newPassword));
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enter a new password')),
                );
              }
            },
            child: const Text("Change"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is PasswordChangedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password changed successfully')),
            );
            _passwordController.clear();
          } else if (state is SettingsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          String fullName = "";
          String email = '';
          String profilePicUrl = '';

          if (state is SettingsLoaded) {
            fullName = state.fullName;
            email = state.email;
            profilePicUrl = state.profilePicUrl;
          } else if (state is ProfilePictureUpdated) {
            profilePicUrl = state.profilePicUrl;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _pickedImage != null
                              ? FileImage(_pickedImage!)
                              : (profilePicUrl.isNotEmpty
                              ? NetworkImage(profilePicUrl)
                              : null) as ImageProvider<Object>?,
                          child: (_pickedImage == null &&
                              (profilePicUrl.isEmpty))
                              ? const Icon(Icons.person, size: 50)
                              : null,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: _pickImage,
                          child: Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(Icons.edit, size: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(fullName, style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 4),
                Text(email, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                const Divider(height: 1),
                _featureCard(
                  title: "Change Password",
                  onTap: _showChangePasswordDialog,
                ),
                const Divider(height: 1),
                _featureCard(
                  title: "Logout",
                  onTap: () {
                    // You can add your logout logic here
                  },
                ),
                const Divider(height: 1),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _featureCard({required String title, void Function()? onTap}) {
    return SizedBox(
      height: 50,
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 16)),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}

