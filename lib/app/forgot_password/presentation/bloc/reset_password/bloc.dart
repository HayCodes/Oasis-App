import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis/app/forgot_password/data/forgot_password.repository.dart';
import 'package:oasis/app/forgot_password/presentation/bloc/reset_password/events.dart';
import 'package:oasis/app/forgot_password/presentation/bloc/reset_password/states.dart';
import 'package:oasis/common/common.dart';

class ResetPasswordBloc extends Bloc<ResetUserPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc(this._forgotPasswordRepository)
    : super(const ResetPasswordState()) {
    on<ResetEmailEvent>(_emailEvent);
    on<ResetPasswordEvent>(_passwordEvent);
    on<ResetPasswordConfirmationEvent>(_passwordConfirmationEvent);
    on<OtpEvent>(_otpEvent);
    on<SubmitResetEvent>(_submitEvent);
  }

  void _emailEvent(ResetEmailEvent event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordEvent(ResetPasswordEvent event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _passwordConfirmationEvent(
    ResetPasswordConfirmationEvent event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(state.copyWith(passwordConfirmation: event.passwordConfirmation));
  }

  void _otpEvent(OtpEvent event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(token: event.otp));
  }

  Future<void> _submitEvent(
    SubmitResetEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(state.copyWith(status: FetchStatus.loading));
    final res = await _forgotPasswordRepository.resetPassword((
      email: state.email,
      password: state.password,
      password_confirmation: state.passwordConfirmation,
      token: state.token,
    ));

    res.fold(
      (error) =>
          emit(state.copyWith(status: FetchStatus.failure, error: error)),
      (result) => emit(state.copyWith(status: FetchStatus.success)),
    );
  }

  final ForgotPasswordRepository _forgotPasswordRepository;
}
