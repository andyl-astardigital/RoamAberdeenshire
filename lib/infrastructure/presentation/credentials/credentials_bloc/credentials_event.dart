import 'package:equatable/equatable.dart';

abstract class ICredentialsEvent extends Equatable {}

class CredentialsEmailChangedEvent extends ICredentialsEvent {
  final String email;

  CredentialsEmailChangedEvent(this.email);

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'CredentialsEmailChangedEvent{ email: $email }';
}

class CredentialsPasswordChangedEvent extends ICredentialsEvent {
  final String password;

  CredentialsPasswordChangedEvent(this.password);

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'CredentialsEmailChangedEvent{ password: $password }';
}

class CredentialsTogglePasswordVisibilityEvent extends ICredentialsEvent {
  CredentialsTogglePasswordVisibilityEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'CredentialsTogglePasswordVisibilityEvent{ }';
}

class CredentialsToggleValidateOnEntryEvent extends ICredentialsEvent {
  CredentialsToggleValidateOnEntryEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'CredentialsToggleValidateOnEntryEvent{ }';
}

class CredentialsValidateLoginEvent extends ICredentialsEvent {
  CredentialsValidateLoginEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'CredentialsValidateEvent{ }';
}

class CredentialsValidateSignupEvent extends ICredentialsEvent {
  CredentialsValidateSignupEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'CredentialsValidateSignupEvent{ }';
}

class CredentialsResetValidationEvent extends ICredentialsEvent {
  CredentialsResetValidationEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'CredentialsResetValidationEvent{ }';
}
