import 'package:equatable/equatable.dart';

abstract class ILoginState extends Equatable {}

class LoginState extends ILoginState {
  LoginState();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginState{  }';
}

class AttemptLoginState extends ILoginState {
  final String email;
  final String password;

  AttemptLoginState(this.email, this.password);

  AttemptLoginState.init({
    this.email = "",
    this.password = "",
  });

  AttemptLoginState copyWith({
    String email,
    String password,
  }) {
    return AttemptLoginState(
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
  String toString() => 'AttemptLoginState{ email:$email, password:$password }';
}

class ValidateLoginState extends ILoginState {
  ValidateLoginState();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ValidateLoginState{  }';
}
