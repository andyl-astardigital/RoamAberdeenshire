import 'package:equatable/equatable.dart';
import 'package:roam_aberdeenshire/domain/entities/app_user.dart';

abstract class IHomeState extends Equatable {}

class HomeNoUserState extends IHomeState {
  HomeNoUserState();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'HomeNoUserState{ }';
}

class HomeState extends IHomeState {
  final AppUser user;
  HomeState(this.user);
  @override
  List<Object> get props => [user];

  @override
  String toString() => 'HomeState{ user: $user }';
}
