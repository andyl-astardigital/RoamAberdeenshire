import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/email_password_login_respository.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/authentication_errors.dart';

import 'authentication_usecase_exports.dart';

abstract class LoginEmailPasswordUseCase {
  Future<AppUser> login(UserCredentials credentials);
}

class LoginEmailPasswordUseCaseImpl implements LoginEmailPasswordUseCase {
  final EmailPasswordLoginRepository loginRepo;
  final AccountProvidersUseCase accountProvidersUseCase;

  LoginEmailPasswordUseCaseImpl(this.loginRepo, this.accountProvidersUseCase);

  Future<AppUser> login(UserCredentials credentials) async {
    var providers =
        await accountProvidersUseCase.getProviders(credentials.email);

    if (providers.isNotEmpty && !providers.contains("email"))
      return Future<AppUser>.error(
          EmailInUsedByOtherProvidersError(credentials.email, providers));

    var user = await loginRepo.create(
        (UserCredentials(credentials.email, password: credentials.password)));

    if (user != null) {
      return Future<AppUser>.value(user);
    }
    return Future<AppUser>.error(NoUserFoundError(credentials));
  }
}
