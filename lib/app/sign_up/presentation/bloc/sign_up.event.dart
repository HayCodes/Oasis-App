abstract class SignUpEvent {
  const SignUpEvent();
}

class NameEvent extends SignUpEvent {
  const NameEvent(this.name);

  final String name;
}

class EmailEvent extends SignUpEvent {
  const EmailEvent(this.email);

  final String email;
}

class PasswordEvent extends SignUpEvent {
  const PasswordEvent(this.password);

  final String password;
}

class PasswordConfirmationEvent extends SignUpEvent {
  const PasswordConfirmationEvent(this.passwordConfirmation);

  final String passwordConfirmation;
}

class TermsEvent extends SignUpEvent {
  const TermsEvent(this.terms);

  final bool terms;
}

class SubmitSignUpEvent extends SignUpEvent {
  const SubmitSignUpEvent();
}