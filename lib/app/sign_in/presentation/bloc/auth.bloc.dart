import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis/app/sign_in/data/sign_in.repository.dart';
import 'package:oasis/app/sign_in/presentation/bloc/auth.event.dart';
import 'package:oasis/app/sign_in/presentation/bloc/auth.state.dart';
import 'package:oasis/common/common.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._repository) : super(const AuthState()) {
    void emailEvent(EmailEvent event, Emitter<AuthState> emit) {
      emit(state.copyWith(email: event.email));
    }

    void passwordEvent(PasswordEvent event, Emitter<AuthState> emit) {
      emit(state.copyWith(password: event.password));
    }

    Future<void> submitLogin(SubmitLoginEvent event,
        Emitter<AuthState> emit) async {
      emit(state.copyWith(status: FetchStatus.loading));

      final result = await _repository.signIn(
        (email: state.email, password: state.password),
      );

      result.fold(
            (error) =>
            emit(state.copyWith(status: FetchStatus.failure, error: error)),
            (user) => emit(state.copyWith(status: FetchStatus.success)),
      );
    }

    on<EmailEvent>(emailEvent);
    on<PasswordEvent>(passwordEvent);
    on<SubmitLoginEvent>(submitLogin);

  }
  final SigninRepository _repository;

}
