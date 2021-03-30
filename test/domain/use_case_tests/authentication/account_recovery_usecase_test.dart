import 'package:roam_aberdeenshire/domain/entities/account_recovery.dart';
import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/account_recovery_repository.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/account_repository.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/authentication_errors.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/domain_error.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/account_recovery_usecase.dart';
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
    return Future.error("Borked");
  }
}

class MockAccountRepo extends AccountRepository {
  @override
  Future<List<AppUser>> retrieveBy(Map<String, dynamic> params) {
    if (params["email"] != null) {
      if (params["email"] == theUser.email) {
        return Future.value([theUser]);
      }
      return Future.value(null);
    }
    return Future.value(null);
  }
}

void main() {
  AccountRecoveryUseCase recoverPasswordUseCase;

  setUp(() {
    recoverPasswordUseCase = AccountRecoveryUseCaseImpl(
        MockAccountRepo(), MockAccountRecoveryRepo(), ValidEmailUseCaseImpl());
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
      recoverPasswordUseCase = AccountRecoveryUseCaseImpl(MockAccountRepo(),
          MockAccountRecoveryReturnsErrorRepo(), ValidEmailUseCaseImpl());
      result = await recoverPasswordUseCase.recoverPassword(email);
    } catch (error) {
      expect(error, isA<DomainError>());
    }
    expect(result, isNull);
  });
}
