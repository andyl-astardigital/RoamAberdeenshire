import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/account_repository.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/signup_repository.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/authentication_errors.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/validation_errors.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_email_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_password_usecase.dart';
import 'package:roam_aberdeenshire/domain/entities/app_user.dart';

abstract class EmailSignupUseCase {
  Future<AppUser> signup(UserCredentials credentials);
}

///Performs the logic to sign up a user with the given details
///
///Future will resolve to the User object for the given details on success
///Future will error with InvalidEmailError if the email is invalid
///Future will error with InvalidPasswordError if the password is invalid
///Future will error with EmailInUseError if the email is already in use
///Future will error with GeneralError on error
class EmailSignupUseCaseImpl implements EmailSignupUseCase {
  final SignupRepository signupRepo;
  final AccountRepository accountRepository;
  final ValidEmailUseCase validEmailUseCase;
  final ValidPasswordUseCase validPasswordUseCase;

  EmailSignupUseCaseImpl(this.signupRepo, this.accountRepository,
      this.validEmailUseCase, this.validPasswordUseCase);

  Future<AppUser> signup(UserCredentials credentials) async {
    if (!validEmailUseCase.validate(credentials.email)) {
      return Future.error(InvalidEmailError(credentials.email));
    }

    if (!validPasswordUseCase.validate(credentials.password)) {
      return Future<AppUser>.error(InvalidPasswordError(credentials.password));
    }

    var account = await accountRepository.retrieveBy(
        ({"email": credentials.email, "password": credentials.password}));

    if (account != null && account.isNotEmpty) {
      return Future<AppUser>.error(EmailInUseError(credentials.email));
    }
    return await signupRepo.create(credentials);
  }
}
