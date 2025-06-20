abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final String fullName;
  final String email;
  final String profilePicUrl;
  SettingsLoaded(this.fullName, this.email, this.profilePicUrl);
}

class SettingsError extends SettingsState {
  final String message;
  SettingsError(this.message);
}

class ProfilePictureUpdated extends SettingsState {
  final String profilePicUrl;
  ProfilePictureUpdated(this.profilePicUrl);
}

class PasswordChangedSuccess extends SettingsState {}
