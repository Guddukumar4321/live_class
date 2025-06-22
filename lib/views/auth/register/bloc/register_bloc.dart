import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_classroom/views/auth/register/bloc/register_event.dart';
import 'package:live_classroom/views/auth/register/bloc/register_state.dart';
import '../../../../services/shared_prefs.dart';
import '../../login/bloc/login_state.dart';
import '../repository/auth_repository.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthRegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onRegisterRequested(
      AuthRegisterRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.registerUser(
        email: event.email,
        password: event.password,
      );

      if (user != null) {
        var data = {
          "user_name":event.fullName,
          "email":event.email,
          "password":event.password
        };

        authRepository.addUserProfile(user.uid,data);
        emit(AuthSuccess());
        SharedPrefs.setUserData("name", false ,event.fullName.toString());
      } else {
        emit(AuthFailure("Login failed. Try again."));
      }

    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
