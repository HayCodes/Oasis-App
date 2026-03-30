import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis/app/sign_in/presentation/bloc/auth.event.dart';
import 'package:oasis/app/sign_in/presentation/bloc/auth.state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    void emailEvent(EmailEvent event, Emitter<AuthState> emit) {
      emit(state.copyWith(email: event.email));
    }

    void passwordEvent(PasswordEvent event, Emitter<AuthState> emit) {
      emit(state.copyWith(password: event.password));
    }

    on<EmailEvent>(emailEvent);
    on<PasswordEvent>(passwordEvent);
  }
}
