import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis/app/forgot_password/data/forgot_password.repository.dart';
import 'package:oasis/app/forgot_password/presentation/bloc/forgot_password/events.dart';
import 'package:oasis/app/forgot_password/presentation/bloc/forgot_password/states.dart';
import 'package:oasis/common/common.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc(this._forgotPasswordRepository)
    : super(const ForgotPasswordState()) {
    on<ForgotPasswordEmailEvent>(_emailEvent);
    on<SubmitForgotPasswordEvent>(_submitEvent);
  }

  void _emailEvent(
    ForgotPasswordEmailEvent event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  Future<void> _submitEvent(
    SubmitForgotPasswordEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(status: FetchStatus.loading));

    final res = await _forgotPasswordRepository.forgotPassword(state.email);
    res.fold(
      (error) =>
          emit(state.copyWith(status: FetchStatus.failure, error: error)),
      (result) => emit(state.copyWith(status: FetchStatus.success)),
    );
  }

  final ForgotPasswordRepository _forgotPasswordRepository;
}
