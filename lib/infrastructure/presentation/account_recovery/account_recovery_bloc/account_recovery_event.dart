import 'package:equatable/equatable.dart';

abstract class IAccountRecoveryEvent extends Equatable {}

class AccountRecoveryValidateEvent extends IAccountRecoveryEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AccountRecoveryValidateEvent{  }';
}

class AccountRecoveryCredentialsValidatedEvent extends IAccountRecoveryEvent {
  final String email;

  AccountRecoveryCredentialsValidatedEvent(this.email);

  @override
  List<Object> get props => [email];

  @override
  String toString() =>
      'AccountRecoveryCredentialsValidatedEvent{ email: $email }';
}
