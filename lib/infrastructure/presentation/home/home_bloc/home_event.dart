import 'package:equatable/equatable.dart';
import 'package:roam_aberdeenshire/domain/entities/app_user.dart';

abstract class IHomeEvent extends Equatable {}

class HomeUserUpdatedEvent extends IHomeEvent {
  final AppUser user;

  HomeUserUpdatedEvent(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'HomeUserUpdatedEvent{ user: $user }';
}
