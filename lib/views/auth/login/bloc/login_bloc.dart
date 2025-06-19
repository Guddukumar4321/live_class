import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../services/shared_prefs.dart';
import '../repository/login_repository.dart';
import 'login_event.dart';
import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc(this.loginRepository) : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
      LoginRequested event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());
    try {
      final user = await loginRepository.loginUser(event.email, event.password);
      if (user != null) {
        await SharedPrefs.saveUser(user.uid, user.email ?? '', true);
        emit(LoginSuccess());
      } else {
        emit(LoginFailure("Login failed. Try again."));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
