import 'package:equatable/equatable.dart';

abstract class IAppErrorEvent extends Equatable {}

class AppErrorShowErrorEvent extends IAppErrorEvent {
  final String error;

  AppErrorShowErrorEvent(this.error);
  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AppErrorShowErrorEvent{ error: $error }';
}

class AppErrorClearEvent extends IAppErrorEvent {
  AppErrorClearEvent();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AppErrorClearEvent{ }';
}
