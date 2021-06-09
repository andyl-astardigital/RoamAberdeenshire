import 'package:roam_aberdeenshire/domain/entities/account_recovery.dart';
import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/account_recovery_repository.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/authentication_errors.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/domain_error.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/account_recovery_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/authentication_usecase_exports.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_email_usecase.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

String email = "foo@bar.com";
Uuid id = Uuid();
AccountRecovery theAccountRecovery = AccountRecovery(email);
AppUser theUser = AppUser("", email);

class MockAccountRecoveryRepo extends AccountRecoveryRepository {
  @override
  Future<bool> create(AccountRecovery obj) {
    return Future.value(true);
  }
}

class MockAccountRecoveryReturnsErrorRepo extends AccountRecoveryRepository {
  @override
  Future<bool> create(AccountRecovery obj) {
    return Future.error(GeneralError("borked"));
  }
}

class MockAccountProvidersUseCase extends AccountProvidersUseCase {
  @override
  Future<List<String>> getProviders(String email) {
    return Future.value(["email"]);
  }
}

class MockAccountProvidersUseCaseFacebook extends AccountProvidersUseCase {
  @override
  Future<List<String>> getProviders(String email) {
    return Future.value(["facebook"]);
  }
}

class MockAccountProvidersUseCaseNone extends AccountProvidersUseCase {
  @override
  Future<List<String>> getProviders(String email) {
    return Future.value([]);
  }
}

void main() {
  AccountRecoveryUseCase recoverPasswordUseCase;

  setUp(() {
    recoverPasswordUseCase = AccountRecoveryUseCaseImpl(
        MockAccountRecoveryRepo(),
        ValidEmailUseCaseImpl(),
        MockAccountProvidersUseCase());
  });

  test('RecoverPassword UseCase returns true when recovery email has been sent',
      () async {
    var result = await recoverPasswordUseCase.recoverPassword(email);

    expect(result, true);
  });

  test('RecoverPassword UseCase errors when details are not correct', () async {
    bool result;
    String email = "a@b.com";
    try {
      recoverPasswordUseCase = AccountRecoveryUseCaseImpl(
          MockAccountRecoveryRepo(),
          ValidEmailUseCaseImpl(),
          MockAccountProvidersUseCaseNone());
      result = await recoverPasswordUseCase.recoverPassword(email);
    } catch (error) {
      expect(error, isA<NoUserFoundError>());
    }
    expect(result, isNull);
  });

  test('RecoverPassword UseCase errors when an error occurs', () async {
    bool result;
    String email = "a@b.com";
    try {
      recoverPasswordUseCase = AccountRecoveryUseCaseImpl(
          MockAccountRecoveryReturnsErrorRepo(),
          ValidEmailUseCaseImpl(),
          MockAccountProvidersUseCase());
      result = await recoverPasswordUseCase.recoverPassword(email);
    } catch (error) {
      expect(error, isA<DomainError>());
    }
    expect(result, isNull);
  });
}
