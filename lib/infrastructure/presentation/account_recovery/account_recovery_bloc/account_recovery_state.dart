import 'package:equatable/equatable.dart';

abstract class IAccountRecoveryState extends Equatable {}

class AccountRecoveryState extends IAccountRecoveryState {
  AccountRecoveryState();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AccountRecoveryState{  }';
}

class AccountRecoveryAttemptState extends IAccountRecoveryState {
  final String email;

  AccountRecoveryAttemptState(this.email);

  AccountRecoveryAttemptState.init({
    this.email = "",
  });

  AccountRecoveryAttemptState copyWith({
    String email,
  }) {
    return AccountRecoveryAttemptState(
      email ?? this.email,
    );
  }

  @override
  List<Object> get props => [
        email,
      ];

  @override
  String toString() => 'AccountRecoveryAttemptState{ email:$email }';
}

class AccountRecoveryValidateState extends IAccountRecoveryState {
  AccountRecoveryValidateState();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AccountRecoveryValidateState{  }';
}

class AccountRecoverySuccessfulState extends IAccountRecoveryState {
  AccountRecoverySuccessfulState();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'AccountRecoverySuccessfulState{ }';
}

class AccountRecoveryErrorState extends IAccountRecoveryState {
  final String error;
  AccountRecoveryErrorState(this.error);
  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AccountRecoveryErrorState{ error: $error }';
}
