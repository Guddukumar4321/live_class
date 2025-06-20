import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> _pickAndCropImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 90,
    );

    if (croppedFile != null) {
      setState(() => _pickedImage = File(croppedFile.path));
      context.read<SettingsBloc>().add(UpdateProfilePicture(_pickedImage!));
    }
  }

  void _changePassword() {
    final newPassword = _passwordController.text.trim();
    if (newPassword.isNotEmpty) {
      context.read<SettingsBloc>().add(ChangePassword(newPassword));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a new password')),
      );
    }
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
          if (state is SettingsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SettingsLoaded || state is ProfilePictureUpdated) {
            final fullName = (state is SettingsLoaded)
                ? state.fullName
                : (state as ProfilePictureUpdated).profilePicUrl;

            final email = (state is SettingsLoaded)
                ? state.email
                : ''; // Only available in initial load

            final profilePicUrl = (state is SettingsLoaded)
                ? state.profilePicUrl
                : (state as ProfilePictureUpdated).profilePicUrl;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickAndCropImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(profilePicUrl),
                      child: profilePicUrl.isEmpty
                          ? const Icon(Icons.person, size: 60)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(fullName, style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 4),
                  Text(email, style: const TextStyle(color: Colors.grey)),
                  const Divider(height: 40),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _changePassword,
                    child: const Text('Change Password'),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text("Something went wrong."));
        },
      ),
    );
  }
}
