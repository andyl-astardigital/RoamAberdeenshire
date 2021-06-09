import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/token_login_respository.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/authentication_errors.dart';

import 'account_providers_usecase.dart';

abstract class LoginTokenUseCase {
  Future<AppUser> login(String token,  String provider);
}

class LoginTokenUseCaseImpl implements LoginTokenUseCase {
  final TokenLoginRepository tokenLoginRepository;
  final AccountProvidersUseCase accountProvidersUseCase;

  LoginTokenUseCaseImpl(
      this.tokenLoginRepository, this.accountProvidersUseCase);

  Future<AppUser> login(String token, String provider) async {
    var user = await tokenLoginRepository.create(token);
    var providers = await accountProvidersUseCase.getProviders(user.email);

    if (providers.isNotEmpty && !providers.contains(provider))
      return Future<AppUser>.error(
          EmailInUsedByOtherProvidersError(user.email, providers));

    if (user != null) {
      return Future<AppUser>.value(user);
    }
    return Future<AppUser>.error(NoUserFoundError(null));
  }
}
