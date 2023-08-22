import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_realm_test/config/realm_config.dart';
import 'package:realm/realm.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginWithEmailAndPassword>(_loginWithEmailAndPassword);
  }

  Future<void> _loginWithEmailAndPassword(
      LoginWithEmailAndPassword event, Emitter<LoginState> emit) async {
    try {
      final RealmConfig realmConfig = RealmConfig.instance;
      final user = await realmConfig.userLogin(
          email: event.email, password: event.password);
      emit(LoginSuccess(user: user));
    } catch (e) {
      emit(LoginError(errorMessage: e.toString()));
    }
  }
}
