import 'package:equatable/equatable.dart';

abstract class ICredentialsEvent extends Equatable {}

class EmailChangedEvent extends ICredentialsEvent {
  final String email;

  EmailChangedEvent(this.email);

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChangedEvent{ email: $email }';
}

class PasswordChangedEvent extends ICredentialsEvent {
  final String password;

  PasswordChangedEvent(this.password);

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'EmailChangedEvent{ password: $password }';
}

class TogglePasswordVisibilityEvent extends ICredentialsEvent {
  TogglePasswordVisibilityEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'TogglePasswordVisibilityEvent{ }';
}

class ToggleValidateOnEntryEvent extends ICredentialsEvent {
  ToggleValidateOnEntryEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'ToggleValidateOnEntryEvent{ }';
}

class ValidateLoginEvent extends ICredentialsEvent {
  ValidateLoginEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'ValidateEvent{ }';
}

class ValidateSignupEvent extends ICredentialsEvent {
  ValidateSignupEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'ValidateSignupEvent{ }';
}
