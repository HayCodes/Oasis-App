abstract class ResetUserPasswordEvent {
  const ResetUserPasswordEvent();
}

class ResetEmailEvent extends ResetUserPasswordEvent {
  const ResetEmailEvent(this.email);

  final String email;
}

class ResetPasswordEvent extends ResetUserPasswordEvent {
  const ResetPasswordEvent(this.password);

  final String password;
}

class ResetPasswordConfirmationEvent extends ResetUserPasswordEvent {
  const ResetPasswordConfirmationEvent(this.passwordConfirmation);

  final String passwordConfirmation;
}

class OtpEvent extends ResetUserPasswordEvent {
  const OtpEvent(this.otp);

  final String otp;
}

class SubmitResetEvent extends ResetUserPasswordEvent {
  const SubmitResetEvent();
}
