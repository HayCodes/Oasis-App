abstract class ForgotPasswordEvent {
  const ForgotPasswordEvent();
}

class ForgotPasswordEmailEvent extends ForgotPasswordEvent{
  const ForgotPasswordEmailEvent(this.email);

  final String email;
}

class SubmitForgotPasswordEvent extends ForgotPasswordEvent{
  const SubmitForgotPasswordEvent();
}