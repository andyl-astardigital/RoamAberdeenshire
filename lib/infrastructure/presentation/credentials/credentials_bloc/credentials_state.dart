import 'package:equatable/equatable.dart';

abstract class ICredentialsState extends Equatable {}

class CredentialsState extends ICredentialsState {
  final String email;
  final String password;
  final bool passwordVisible;
  final bool emailValid;
  final bool passwordValid;
  final bool validateOnEntry;

  CredentialsState(this.email, this.password, this.passwordVisible,
      this.emailValid, this.passwordValid, this.validateOnEntry);

  CredentialsState.init(
      {this.email = "",
      this.password = "",
      this.passwordVisible: false,
      this.emailValid: true,
      this.passwordValid: true,
      this.validateOnEntry: false});

  CredentialsState copyWith(
      {String email,
      String password,
      bool passwordVisible,
      bool emailValid,
      bool passwordValid,
      bool validateOnEntry}) {
    return CredentialsState(
        email ?? this.email,
        password ?? this.password,
        passwordVisible ?? this.passwordVisible,
        emailValid ?? this.emailValid,
        passwordValid ?? this.passwordValid,
        validateOnEntry ?? this.validateOnEntry);
  }

  @override
  List<Object> get props => [
        email,
        password,
        passwordVisible,
        emailValid,
        passwordValid,
        validateOnEntry
      ];

  @override
  String toString() =>
      'CredentialsState{ email:$email, password:$password, passwordVisible: $passwordVisible, emailValid: $emailValid, passwordValid: $passwordValid, validateOnEntry: $validateOnEntry }';
}

class ValidLoginCredentialsState extends ICredentialsState {
  final String email;
  final String password;

  ValidLoginCredentialsState(this.email, this.password);

  ValidLoginCredentialsState.init({
    this.email = "",
    this.password = "",
  });

  ValidLoginCredentialsState copyWith({
    String email,
    String password,
  }) {
    return ValidLoginCredentialsState(
      email ?? this.email,
      password ?? this.password,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
      ];

  @override
  String toString() =>
      'ValidCredentialsState{ email:$email, password:$password }';
}

class ValidSignupCredentialsState extends ValidLoginCredentialsState {
  ValidSignupCredentialsState(String email, String password)
      : super(email, password);
}
