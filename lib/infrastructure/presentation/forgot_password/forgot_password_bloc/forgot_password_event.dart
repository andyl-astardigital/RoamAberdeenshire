import 'package:equatable/equatable.dart';

abstract class ILoginEvent extends Equatable {}

class EmailChangedEvent extends ILoginEvent {
  final String email;

  EmailChangedEvent(this.email);

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChangedEvent{ email:$email }';
}

class PasswordChangedEvent extends ILoginEvent {
  final String password;

  PasswordChangedEvent(this.password);

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChangedEvent{ email:$password }';
}

class PasswordVisibilityEvent extends ILoginEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'PasswordVisibilityEvent{  }';
}

class ToggleSignUpModeEvent extends ILoginEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ToggleSignUpModeEvent{  }';
}

class ToggleForgotPasswordModeEvent extends ILoginEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ToggleForgotPasswordModeEvent{  }';
}

class AuthErrorEvent extends ILoginEvent {
  final String error;

  AuthErrorEvent(this.error);
  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AuthErrorEvent{ error:$error }';
}

class LoggingInEvent extends ILoginEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoggingInEvent{  }';
}

class SigningUpEvent extends ILoginEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'SigningUpEvent{  }';
}

class ForgotPasswordEvent extends ILoginEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ForgotPasswordEvent{  }';
}
