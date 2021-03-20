import 'package:equatable/equatable.dart';

abstract class ILoginEvent extends Equatable {}

class AttemptLoginEvent extends ILoginEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AttemptLoginEvent{  }';
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
