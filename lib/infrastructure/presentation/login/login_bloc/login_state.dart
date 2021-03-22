import 'package:equatable/equatable.dart';
import 'package:roam_aberdeenshire/domain/entities/user.dart';

abstract class ILoginState extends Equatable {}

class LoginState extends ILoginState {
  LoginState();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginState{  }';
}

class LoginSuccessfulState extends ILoginState {
  final User user;

  LoginSuccessfulState(this.user);

  @override
  List<Object> get props => [
        user,
      ];

  @override
  String toString() => 'LoginSuccessfulState{ user:$user }';
}

class LoginValidateState extends ILoginState {
  LoginValidateState();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ValidateLoginState{  }';
}

class LoginErrorState extends ILoginState {
  final String error;
  LoginErrorState(this.error);
  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginErrorState{ error: $error }';
}
