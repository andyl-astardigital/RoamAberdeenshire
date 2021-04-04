import 'package:equatable/equatable.dart';
import 'package:roam_aberdeenshire/domain/entities/app_user.dart';

abstract class IFacebookState extends Equatable {}

class FacebookLoginCancelledState extends IFacebookState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'FacebookLoginCancelledState { }';
}

class FacebookLoggedInState extends IFacebookState {
  final AppUser user;

  FacebookLoggedInState(this.user);
  @override
  List<Object> get props => [user];

  @override
  String toString() => 'FacebookLoggedInState { user: $user }';
}

class FacebookLoggedOutState extends IFacebookState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'FacebookLoggedOutState { }';
}

class FacebookErrorState extends IFacebookState {
  final String error;
  FacebookErrorState(this.error);
  @override
  List<Object> get props => [error];

  @override
  String toString() => 'FacebookErrorState{ error: $error }';
}
