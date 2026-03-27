abstract class AuthEvent {
  const AuthEvent();
}

class EmailEvent extends AuthEvent {
  const EmailEvent(this.email);

  final String email;
}

class PasswordEvent extends AuthEvent {
  const PasswordEvent(this.password);

  final String password;
}
