import 'package:equatable/equatable.dart';

abstract class ILoginEvent extends Equatable {}

class LoginValidateEvent extends ILoginEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginValidateEvent{  }';
}

class LoginWithFacebookEvent extends ILoginEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginWithFacebookEvent{  }';
}

class LoginCredentialsValidatedEvent extends ILoginEvent {
  final String email;
  final String password;

  LoginCredentialsValidatedEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'LoginCredentialsValidatedEvent{ email: $email, password: $password }';
}
