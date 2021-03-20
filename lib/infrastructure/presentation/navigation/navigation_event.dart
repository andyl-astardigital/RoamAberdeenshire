import 'package:equatable/equatable.dart';

abstract class INavigationEvent extends Equatable {}

class ShowLoginPageEvent extends INavigationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ShowLoginPageEvent{ }';
}

class ShowSignupPageEvent extends INavigationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ShowSignupPageEvent{ }';
}

class ShowForgotPageEvent extends INavigationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ShowForgotPageEvent{ }';
}

class ShowHomePageEvent extends INavigationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ShowHomePageEvent{ }';
}

class ShowErrorEvent extends INavigationEvent {
  final String error;
  ShowErrorEvent(this.error);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'ShowErrorEvent{ error: $error }';
}
