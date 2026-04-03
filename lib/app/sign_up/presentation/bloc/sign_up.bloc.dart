import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis/app/sign_up/data/sign_up.repository.dart';
import 'package:oasis/app/sign_up/presentation/bloc/sign_up.event.dart';
import 'package:oasis/app/sign_up/presentation/bloc/sign_up.state.dart';
import 'package:oasis/common/common.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this.repository) : super(const SignUpState()) {
    void nameEvent(NameEvent event, Emitter<SignUpState> emit) {
      emit(state.copyWith(name: event.name));
    }

    void emailEvent(EmailEvent event, Emitter<SignUpState> emit) {
      emit(state.copyWith(email: event.email));
    }

    void passwordEvent(PasswordEvent event, Emitter<SignUpState> emit) {
      emit(state.copyWith(password: event.password));
    }

    void passwordConfirmationEvent(
      PasswordConfirmationEvent event,
      Emitter<SignUpState> emit,
    ) {
      emit(state.copyWith(passwordConfirmation: event.passwordConfirmation));
    }

    void termsEvent(TermsEvent event, Emitter<SignUpState> emit) {
      emit(state.copyWith(terms: event.terms));
    }

    Future<void> submitEvent(
      SubmitSignUpEvent event,
      Emitter<SignUpState> emit,
    ) async {
      emit(state.copyWith(status: FetchStatus.loading));

      final result = await repository.signup((
        name: state.name,
        email: state.email,
        password: state.password,
        passwordConfirmation: state.passwordConfirmation,
        terms: state.terms,
      ));

      result.fold(
        (error) =>
            emit(state.copyWith(status: FetchStatus.failure, error: error)),
        (name) => emit(state.copyWith(status: FetchStatus.success)),
      );
    }

    on<NameEvent>(nameEvent);
    on<EmailEvent>(emailEvent);
    on<PasswordEvent>(passwordEvent);
    on<PasswordConfirmationEvent>(passwordConfirmationEvent);
    on<TermsEvent>(termsEvent);
    on<SubmitSignUpEvent>(submitEvent);
  }

  final SignupRepository repository;
}
