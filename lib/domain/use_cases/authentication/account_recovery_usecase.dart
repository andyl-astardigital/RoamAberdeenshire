import 'package:roam_aberdeenshire/domain/entities/account_recovery.dart';
import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/account_recovery_repository.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/account_repository.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/authentication_errors.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/validation_errors.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_email_usecase.dart';

abstract class AccountRecoveryUseCase {
  Future<bool> recoverPassword(String email);
}

///Performs the logic to send an email to recover a user account with the given details
///
///Future will resolve to true if an email has been sent to the email address given
///Future will error with InvalidEmailError if the email is invalid
///Future will error with NoUserFoundError if there is no account for the email
///Future will error with GeneralError on error
class AccountRecoveryUseCaseImpl implements AccountRecoveryUseCase {
  final AccountRecoveryRepository accountRecoveryRepository;
  final AccountRepository accountRepository;
  final ValidEmailUseCase validEmailUseCase;

  AccountRecoveryUseCaseImpl(this.accountRepository,
      this.accountRecoveryRepository, this.validEmailUseCase);

  Future<bool> recoverPassword(String email) async {
    if (!validEmailUseCase.validate(email)) {
      return Future.error(InvalidEmailError(email));
    }
    var account = await accountRepository.retrieveBy(({"email": email}));
    if (account == null || account.isEmpty) {
      return Future<bool>.error(NoUserFoundError(UserCredentials(email)));
    }
    return await accountRecoveryRepository.create(AccountRecovery(email));
  }
}
