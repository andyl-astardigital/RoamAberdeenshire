import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/account_repository.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/email_password_signup_repository.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/authentication_errors.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/validation_errors.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_email_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_password_usecase.dart';
import 'package:roam_aberdeenshire/domain/entities/app_user.dart';

import 'authentication_usecase_exports.dart';

abstract class SignupEmailPasswordUseCase {
  Future<AppUser> signup(UserCredentials credentials);
}

class SignupEmailPasswordUseCaseImpl implements SignupEmailPasswordUseCase {
  final EmailPasswordSignupRepository signupRepo;
 
  final AccountProvidersUseCase accountProvidersUseCase;
  final ValidEmailUseCase validEmailUseCase;
  final ValidPasswordUseCase validPasswordUseCase;

  SignupEmailPasswordUseCaseImpl(
      this.signupRepo,
      this.validEmailUseCase,
      this.validPasswordUseCase,
      this.accountProvidersUseCase);

  Future<AppUser> signup(UserCredentials credentials) async {
    if (!validEmailUseCase.validate(credentials.email)) {
      return Future.error(InvalidEmailError(credentials.email));
    }

    if (!validPasswordUseCase.validate(credentials.password)) {
      return Future<AppUser>.error(InvalidPasswordError(credentials.password));
    }

    var providers =
        await accountProvidersUseCase.getProviders(credentials.email);

    if (providers.isNotEmpty)
      return Future<AppUser>.error(
          EmailInUsedByOtherProvidersError(credentials.email, providers));

    return await signupRepo.create(credentials);
  }
}
