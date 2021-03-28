import 'package:roam_aberdeenshire/domain/entities/account_recovery.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/account_recovery_repository.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/account_repository.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_email_usecase.dart';
import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/shared/domain_error.dart';

class AccountRecoveryUseCaseMessages {
  static final problem = "There was a problem recovering the account.";
  static final noAccount = "No account match the given details.";
}

class NoUserFoundError extends DomainError {
  NoUserFoundError(String message, List<String> value) : super(message, value);
}

abstract class AccountRecoveryUseCase {
  Future<bool> recoverPassword(String email);
}

///Performs the logic to send an email to recover a user account with the given details
///
///Future will resolve to true if an email has been sent to the email address given
///Future will error with DomainError if the email is invalid
///Future will error with NoUserFoundError if there is no account for the email
///Future will error with DomainError on error
class AccountRecoveryUseCaseImpl implements AccountRecoveryUseCase {
  final AccountRecoveryRepository accountRecoveryRepository;
  final AccountRepository accountRepository;
  final ValidEmailUseCase validEmailUseCase;

  AccountRecoveryUseCaseImpl(this.accountRepository,
      this.accountRecoveryRepository, this.validEmailUseCase);

  Future<bool> recoverPassword(String email) async {
    if (!validEmailUseCase.validate(email)) {
      return Future.error(DomainError("Email is invalid ", email));
    }
    return Future.value(await accountRepository
        .retrieveBy(({"email": email}))
        .then((value) async {
      if (value == null || value.isEmpty) {
        return Future<bool>.error(NoUserFoundError(
            AccountRecoveryUseCaseMessages.noAccount, [email]));
      }

      await accountRecoveryRepository.create(AccountRecovery(email));

      return true;
    }, onError: (error) {
      return Future<AppUser>.error(
          DomainError(AccountRecoveryUseCaseMessages.problem, [email]));
    }));
  }
}