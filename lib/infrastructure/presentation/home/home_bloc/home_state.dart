import 'package:equatable/equatable.dart';
import 'package:roam_aberdeenshire/domain/entities/app_user.dart';

abstract class IHomeState extends Equatable {}

class HomeState extends IHomeState {
  HomeState();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'HomeState{  }';
}
