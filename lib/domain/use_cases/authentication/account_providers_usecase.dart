import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/account_providers_repository.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_email_usecase.dart';

abstract class AccountProvidersUseCase {
  Future<List<String>> getProviders(String email);
}

class AccountProvidersUseCaseImpl implements AccountProvidersUseCase {
  final AccountProvidersRepository accountProvidersRepository;
  final ValidEmailUseCase validEmailUseCase;

  AccountProvidersUseCaseImpl(
      this.accountProvidersRepository, this.validEmailUseCase);

  Future<List<String>> getProviders(String email) async {
    var providers =
        await accountProvidersRepository.retrieveBy({"email": email});

    return Future<List<String>>.value(providers);
  }
}
