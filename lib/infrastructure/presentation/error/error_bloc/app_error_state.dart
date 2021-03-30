import 'package:equatable/equatable.dart';

abstract class IAppErrorState extends Equatable {}

class AppErrorClearErrorState extends IAppErrorState {
  AppErrorClearErrorState();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AppErrorClearErrorState{  }';
}

class AppErrorHasErrorState extends IAppErrorState {
  final String error;
  AppErrorHasErrorState(this.error);
  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AppErrorHasErrorState{ error: $error }';
}
