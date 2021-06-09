import 'package:roam_aberdeenshire/domain/entities/account_recovery.dart';
import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/account_recovery_repository.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/authentication_errors.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/validation_errors.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/account_providers_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_email_usecase.dart';

abstract class AccountRecoveryUseCase {
  Future<bool> recoverPassword(String email);
}

class AccountRecoveryUseCaseImpl implements AccountRecoveryUseCase {
  final AccountRecoveryRepository accountRecoveryRepository;
  final AccountProvidersUseCase accountProvidersUseCase;
  final ValidEmailUseCase validEmailUseCase;

  AccountRecoveryUseCaseImpl(this.accountRecoveryRepository,
      this.validEmailUseCase, this.accountProvidersUseCase);

  Future<bool> recoverPassword(String email) async {
    if (!validEmailUseCase.validate(email)) {
      return Future.error(InvalidEmailError(email));
    }
    var providers = await accountProvidersUseCase.getProviders(email);
    if (providers.isEmpty) {
      return Future<bool>.error(NoUserFoundError(UserCredentials(email)));
    }
    if (providers.contains("email")) {
      return await accountRecoveryRepository.create(AccountRecovery(email));
    }
    return Future<bool>.error(
        EmailInUsedByOtherProvidersError(email, providers));
  }
}
