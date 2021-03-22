import 'package:equatable/equatable.dart';

abstract class IErrorState extends Equatable {}

class ErrorClearErrorState extends IErrorState {
  ErrorClearErrorState();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ErrorState{  }';
}

class ErrorHasErrorState extends IErrorState {
  final String error;
  ErrorHasErrorState(this.error);
  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ErrorHasErrorState{ error: $error }';
}
