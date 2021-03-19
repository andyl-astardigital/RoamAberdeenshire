import 'package:equatable/equatable.dart';
import 'package:roam_aberdeenshire/domain/entities/user.dart';

abstract class IAuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStartedEvent extends IAuthenticationEvent {
  @override
  String toString() => 'AppStartedEvent';
}

class LoginAttemptEvent extends IAuthenticationEvent {
  final String email;

  LoginAttemptEvent(this.email);

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'LoginEvent { email:$email }';
}

class SignInErrorEvent extends IAuthenticationEvent {
  final String error;
  SignInErrorEvent(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SignInErrorEvent { email:$error }';
}

class SignOutEvent extends IAuthenticationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'SignOutEvent { }';
}

class PasswordAddedEvent extends IAuthenticationEvent {
  final String password;

  PasswordAddedEvent(this.password);

  @override
  List<Object> get props => [this.password];

  @override
  String toString() => 'SignOutEvent { password:$password }';
}

class SignedInEvent extends IAuthenticationEvent {
  final User user;

  SignedInEvent(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'SignInViaLinkEvent { user:$user }';
}
