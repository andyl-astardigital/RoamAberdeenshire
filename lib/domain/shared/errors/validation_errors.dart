import 'domain_error.dart';

class ValidationErrorMessages {
  static String emailInvalid = "The email address is not valid.";
  static String passwordInvalid = "The password is not strong enough.";
}

class InvalidEmailError extends DomainError {
  InvalidEmailError(String email)
      : super(ValidationErrorMessages.emailInvalid, email);
}

class InvalidPasswordError extends DomainError {
  InvalidPasswordError(String password)
      : super(ValidationErrorMessages.passwordInvalid, password);
}
