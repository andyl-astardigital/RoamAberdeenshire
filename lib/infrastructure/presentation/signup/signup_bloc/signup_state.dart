import 'package:equatable/equatable.dart';

abstract class ISignupState extends Equatable {}

class SignupState extends ISignupState {
  SignupState();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'SignupState{  }';
}

class AttemptSignupState extends ISignupState {
  final String email;
  final String password;

  AttemptSignupState(this.email, this.password);

  AttemptSignupState.init({
    this.email = "",
    this.password = "",
  });

  AttemptSignupState copyWith({
    String email,
    String password,
  }) {
    return AttemptSignupState(
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
  String toString() => 'AttemptSignupState{ email:$email, password:$password }';
}

class ValidateSignupState extends ISignupState {
  ValidateSignupState();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ValidateSignupState{  }';
}
