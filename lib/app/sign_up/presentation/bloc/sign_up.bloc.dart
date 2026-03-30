import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis/app/sign_up/presentation/bloc/sign_up.event.dart';
import 'package:oasis/app/sign_up/presentation/bloc/sign_up.state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
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

    on<NameEvent>(nameEvent);
    on<EmailEvent>(emailEvent);
    on<PasswordEvent>(passwordEvent);
    on<PasswordConfirmationEvent>(passwordConfirmationEvent);
    on<TermsEvent>(termsEvent);
  }
}
