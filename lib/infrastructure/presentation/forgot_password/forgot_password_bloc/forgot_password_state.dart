import 'package:equatable/equatable.dart';

abstract class ILoginState extends Equatable {}

//todo make this another bloc!
class ErrorState extends ILoginState {
  final String error;
  ErrorState(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ErrorState { error:$error }';
}

class LoginState extends ILoginState {
  final String email;
  final String password;

  LoginState(this.email, this.password);

  LoginState.init({
    this.email = "",
    this.password = "",
  });

  LoginState copyWith({
    String email,
    String password,
  }) {
    return LoginState(
      email ?? this.email,
      password ?? this.password,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
      ];

  @override
  String toString() => 'LoginState{ email:$email, password:$password }';
}

class LoggingInState extends ILoginState {
  final String email;
  final String password;

  LoggingInState(this.email, this.password);
  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'LoggingInState{ email:$email, password:$password }';
}

class SigningUpState extends ILoginState {
  final String email;
  final String password;

  SigningUpState(this.email, this.password);
  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'SigningUpState{ email:$email, password:$password }';
}

class ForgotPasswordState extends ILoginState {
  final String email;

  ForgotPasswordState(this.email);
  @override
  List<Object> get props => [email];

  @override
  String toString() => 'SigningUpState{ email:$email }';
}
