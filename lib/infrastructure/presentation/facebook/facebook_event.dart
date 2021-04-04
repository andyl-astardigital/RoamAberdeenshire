import 'package:equatable/equatable.dart';

abstract class IFacebookEvent extends Equatable {}

class FacebookLoginEvent extends IFacebookEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'FacebookLoginEvent{ }';
}
