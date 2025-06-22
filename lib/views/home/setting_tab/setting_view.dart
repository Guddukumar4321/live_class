import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../core/route/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../../services/shared_prefs.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_input_field.dart';
import 'bloc/setting_bloc.dart';
import 'bloc/setting_event.dart';
import 'bloc/setting_state.dart';
import 'image_crop.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingView> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  File? _pickedImage;
  String fullName = "";
  String email = '';
  String profilePicUrl = '';

  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().add(LoadUserProfile());
    Future.delayed(Duration.zero, () async {
       fullName = await SharedPrefs.getUserData("name", false);
       email = await SharedPrefs.getUserData("email", false);
      setState(() {

      });
    });
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) return;

      File tempImage = File(pickedFile.path);

      final croppedBytes = await Navigator.push(context, MaterialPageRoute(builder: (context) => CropSample(tempImage: tempImage),),);
      if (croppedBytes != null) {
        final directory = await getTemporaryDirectory();
        final filePath = '${directory.path}/cropped_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final File file = await File(filePath).writeAsBytes(croppedBytes);

        _pickedImage = file;

        if (mounted) {
          setState(() {});
        }
         context.read<SettingsBloc>().add(UpdateProfilePicture(file));
      }
    } catch (e) {
      debugPrint('Image pick error: $e');
    }
  }





  void _showChangePasswordDialog() {
    _passwordController.clear();
    _oldPasswordController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(

        title: const Text("Change Password"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            CustomInputField(
              controller: _oldPasswordController,
              label: 'Old Password',
              icon: Icons.lock_outline,
              obscureText: true,
              suffixIcon: Icon(Icons.check_circle, color: Colors.green),
              validator: (value) =>
              value!.length < 6 ? 'Too short' : null,
            ),

            SizedBox(height: 10,),
            CustomInputField(
              controller: _passwordController,
              label: 'New Password',
              icon: Icons.lock_outline,
              obscureText: true,
              suffixIcon: Icon(Icons.check_circle, color: Colors.green),
              validator: (value) =>
              value!.length < 6 ? 'Too short' : null,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final oldPassword = _oldPasswordController.text.trim();
              final newPassword = _passwordController.text.trim();
              if (newPassword.isNotEmpty) {
                context.read<SettingsBloc>().add(ChangePassword(newPassword, oldPassword));
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
      appBar: CustomAppBar(title: "Setting",),

      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is PasswordChangedSuccess) {
            context.read<SettingsBloc>().add(LoadUserProfile());
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
                    SharedPrefs.logout();
                    Navigator.pushReplacementNamed(context, AppRoutes.register);
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

