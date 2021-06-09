import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';

import 'domain_error.dart';

class AuthenticationErrorMessages {
  static String emailInUse = "The email address is already in use.";
  static String emailInUseByTheseProviders =
      "The email address is already in use. Please use one of these Login methods: ";
  static String noUserFound = "There is no account with the given details.";
  static String loginProblem =
      "There was a problem while Logging in. Check the details and try again.";
  static String signupProblem =
      "There was a problem while Logging in. Check the details and try again.";
}

class EmailInUseError extends DomainError {
  EmailInUseError(String email)
      : super(AuthenticationErrorMessages.emailInUse, email);
}

class EmailInUsedByOtherProvidersError extends DomainError {
  final List<String> providers;
  EmailInUsedByOtherProvidersError(String email, this.providers)
      : super(AuthenticationErrorMessages.emailInUseByTheseProviders, email);
}

class NoUserFoundError extends DomainError {
  NoUserFoundError(UserCredentials credentials)
      : super(AuthenticationErrorMessages.noUserFound, credentials);
}

class LoginError extends DomainError {
  LoginError(UserCredentials credentials)
      : super(AuthenticationErrorMessages.loginProblem, credentials);
}

class SignupError extends DomainError {
  SignupError(String message, UserCredentials credentials)
      : super(AuthenticationErrorMessages.signupProblem, credentials);
}
