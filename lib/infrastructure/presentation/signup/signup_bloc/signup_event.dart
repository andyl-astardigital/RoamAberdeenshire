import 'package:equatable/equatable.dart';

abstract class ISignupEvent extends Equatable {}

class AttemptSignupEvent extends ISignupEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AttemptLoginEvent{  }';
}

class SignupCredentialsValidatedEvent extends ISignupEvent {
  final String email;
  final String password;

  SignupCredentialsValidatedEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'SignupCredentialsValidatedEvent{ email: $email, password: $password }';
}
