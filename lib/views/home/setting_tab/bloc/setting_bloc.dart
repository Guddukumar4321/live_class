import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_classroom/views/home/setting_tab/bloc/setting_event.dart';
import 'package:live_classroom/views/home/setting_tab/bloc/setting_state.dart';

import '../repository/settings_repository.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository repo;
  SettingsBloc(this.repo) : super(SettingsInitial()) {
    on<LoadUserProfile>(_loadUser);
    on<UpdateProfilePicture>(_updatePicture);
    on<ChangePassword>(_changePassword);
  }

  Future<void> _loadUser(LoadUserProfile event, Emitter emit) async {
    emit(SettingsLoading());
    try {
      final user = await repo.fetchUserProfile();
      emit(SettingsLoaded(user.userName??"", user.email??"", user.profile??""));
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> _updatePicture(UpdateProfilePicture event, Emitter emit) async {
    emit(SettingsLoading());
    try {
      final url = await repo.uploadProfilePicture(event.imageFile);
      emit(ProfilePictureUpdated(url));

    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> _changePassword(ChangePassword event, Emitter emit) async {
    try {
      await repo.changePassword(newPassword:event.newPassword, currentPassword:event.oldPassword);
      emit(PasswordChangedSuccess());
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }
}
