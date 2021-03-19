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
  final bool emailInvalid;
  final String password;
  final bool passwordIsMissing;
  final bool passwordVisible;
  final bool signUpMode;

  LoginState(
      this.email, this.emailInvalid, this.password, this.passwordVisible, this.passwordIsMissing, this.signUpMode);

  LoginState.init(
      {this.email = "",
      this.emailInvalid = false,
      this.password = "",
      this.passwordVisible = false,
      this.passwordIsMissing = false,
      this.signUpMode = false});

  LoginState copyWith({
    String email,
    bool emailInvalid,
    String password,
    bool passwordVisible,
    bool passwordIsMissing,
    bool signUpMode
  }) {
    return LoginState(
      email ?? this.email,
      emailInvalid ?? this.emailInvalid,
      password ?? this.password,
      passwordVisible ?? this.passwordVisible,
      passwordIsMissing ?? this.passwordIsMissing,
      signUpMode ?? this.signUpMode
    );
  }

  @override
  List<Object> get props => [
        email,
        emailInvalid,
        password,
        passwordVisible,
        passwordIsMissing,
        signUpMode
      ];

  @override
  String toString() => 'LoginState{ email:$email, emailInvalid:$emailInvalid. password:$password, passwordVisible:$passwordVisible, passwordIsMissing:$passwordIsMissing, isSignUpMode:$signUpMode }';
}

class LoggingInState extends ILoginState {
  final String email;

  LoggingInState(this.email);
  @override
  List<Object> get props => [email];

  @override
  String toString() => 'LoggingInState{ email:$email }';
}
