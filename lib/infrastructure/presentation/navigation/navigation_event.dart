import 'package:equatable/equatable.dart';

abstract class INavigationEvent extends Equatable {}

class NavigationShowLoginEvent extends INavigationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'NavigationShowLoginEvent{ }';
}

class NavigationShowSignupEvent extends INavigationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'NavigationShowSignupEvent{ }';
}

class NavigationShowForgotEvent extends INavigationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'NavigationShowForgotEvent{ }';
}

class NavigationShowHomeEvent extends INavigationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'NavigationShowHomeEvent{ }';
}
