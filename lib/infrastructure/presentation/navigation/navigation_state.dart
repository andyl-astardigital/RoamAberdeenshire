import 'package:equatable/equatable.dart';

abstract class INavigationState extends Equatable {}

class ShowLoginPageState extends INavigationState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ShowLoginPageState { }';
}

class ShowSignupPageState extends INavigationState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ShowSignupPageState { }';
}

class ShowForgotPasswordPageState extends INavigationState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ShowForgotPasswordPageState { }';
}

class ShowHomePageState extends INavigationState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ShowHomePageState { }';
}

class ShowErrorState extends INavigationState {
  final String error;

  ShowErrorState(this.error);
  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ShowErrorState { error: $error }';
}
