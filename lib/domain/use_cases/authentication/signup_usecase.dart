import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/account_repository.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/signup_repository.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_email_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_password_usecase.dart';

import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/shared/domain_error.dart';

class SignupUseCaseMessages {
  static final problem = "There was a problem during signup.";
  static final alreadyInUse = "Email address already in use.";
}

class EmailInUseError extends DomainError {
  EmailInUseError(String message, UserCredentials credentials)
      : super(message, credentials);
}

abstract class SignupUseCase {
  Future<AppUser> signup(UserCredentials credentials);
}

///Performs the logic to sign up a user with the given details
///
///Future will resolve to the User object for the given details on success
///Future will error with DomainError if the email is invalid
///Future will error with DomainError if the password is invalid
///Future will error with EmailInUseError if the email is already in use
///Future will error with DomainError on error
class SignupUseCaseImpl implements SignupUseCase {
  final SignupRepository signupRepo;
  final AccountRepository accountRepository;
  final ValidEmailUseCase validEmailUseCase;
  final ValidPasswordUseCase validPasswordUseCase;

  SignupUseCaseImpl(this.signupRepo, this.accountRepository,
      this.validEmailUseCase, this.validPasswordUseCase);

  Future<AppUser> signup(UserCredentials credentials) async {
    if (!validEmailUseCase.validate(credentials.email)) {
      return Future.error(DomainError("Email is invalid ", credentials));
    }

    if (!validPasswordUseCase.validate(credentials.password)) {
      return Future<AppUser>.error(
          DomainError("Password isn't strong enough", credentials));
    }

    return Future.value(await accountRepository
        .retrieveBy(
            ({"email": credentials.email, "password": credentials.password}))
        .then((value) async {
      if (value != null && value.isNotEmpty) {
        return Future<AppUser>.error(
            EmailInUseError(SignupUseCaseMessages.alreadyInUse, credentials));
      }

      var user =
          await signupRepo.create(credentials).onError((error, stackTrace) {
        return Future<AppUser>.error(
            DomainError(SignupUseCaseMessages.problem, credentials));
      });
      return user;
    }, onError: (error) {
      //only catch erros from the account repo otherwise the internal call gets swallowed
      return Future<AppUser>.error(
          DomainError(SignupUseCaseMessages.problem, credentials));
    }));
  }
}
