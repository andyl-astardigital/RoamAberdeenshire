import 'package:equatable/equatable.dart';
import 'package:roam_aberdeenshire/domain/entities/user.dart';

abstract class IAuthenticationState extends Equatable {}

class SignedInState extends IAuthenticationState {
  final User user;

  SignedInState(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'SignedInState { user:$user }';
}

class AuthErrorState extends IAuthenticationState {
  final String error;
  AuthErrorState(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AuthErrorState { email:$error }';
}

class NotSignedInState extends IAuthenticationState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'NotSignedInState { }';
}
