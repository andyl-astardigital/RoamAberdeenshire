import 'package:equatable/equatable.dart';

abstract class INavigationState extends Equatable {}

class NavigationShowLoginState extends INavigationState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'NavigationShowLoginState { }';
}

class NavigationShowSignupState extends INavigationState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'NavigationShowSignupState { }';
}

class NavigationShowAccountRecoveryState extends INavigationState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'NavigationShowAccountRecoveryState { }';
}

class NavigationShowHomeState extends INavigationState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'NavigationShowHomeState { }';
}
