import 'package:equatable/equatable.dart';

abstract class IErrorEvent extends Equatable {}

class ErrorShowErrorEvent extends IErrorEvent {
  final String error;

  ErrorShowErrorEvent(this.error);
  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ErrorShowErrorEvent{ error: $error }';
}

class ErrorClearEvent extends IErrorEvent {
  ErrorClearEvent();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ErrorClearEvent{ }';
}
