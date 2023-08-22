import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_realm_test/config/realm_config.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterWithEmailAndPasswordEvent>(_registerWithEmailAndPassword);
  }

  Future<void> _registerWithEmailAndPassword(
      RegisterWithEmailAndPasswordEvent event,
      Emitter<RegisterState> emit) async {
    try {
      final RealmConfig realmConfig = RealmConfig.instance;
      realmConfig.userRegister(email: event.email, password: event.password);
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterError(errorMessage: e.toString()));
    }
  }
}
