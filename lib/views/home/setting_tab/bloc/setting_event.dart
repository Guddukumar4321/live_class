import 'dart:io';

abstract class SettingsEvent {}

class LoadUserProfile extends SettingsEvent {}

class UpdateProfilePicture extends SettingsEvent {
  final File imageFile;
  UpdateProfilePicture(this.imageFile);
}

class ChangePassword extends SettingsEvent {
  final String oldPassword;
  final String newPassword;
  ChangePassword(this.newPassword, this.oldPassword);
}
