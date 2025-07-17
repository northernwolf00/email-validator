abstract class EmailEvent {}

class EmailChanged extends EmailEvent {
  final String email;
  EmailChanged(this.email);
}

class PasswordChanged extends EmailEvent {
  final String password;
  PasswordChanged(this.password);
}

class TogglePasswordVisibility extends EmailEvent {}

class SubmitPressed extends EmailEvent {}
