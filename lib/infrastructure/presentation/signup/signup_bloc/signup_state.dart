import 'package:equatable/equatable.dart';
import 'package:roam_aberdeenshire/domain/entities/app_user.dart';

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

class SignupValidateState extends ISignupState {
  SignupValidateState();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'SignupValidateState{  }';
}

class SignupSuccessfulState extends ISignupState {
  final AppUser user;

  SignupSuccessfulState(this.user);

  @override
  List<Object> get props => [
        user,
      ];

  @override
  String toString() => 'SignupSuccessfulState{ user:$user }';
}

class SignupErrorState extends ISignupState {
  final String error;
  SignupErrorState(this.error);
  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SignupErrorState{ error: $error }';
}
