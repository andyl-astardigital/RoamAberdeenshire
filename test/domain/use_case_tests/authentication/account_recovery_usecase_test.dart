import 'package:roam_aberdeenshire/domain/entities/account_recovery.dart';
import 'package:roam_aberdeenshire/domain/entities/user.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/account_recovery_repository.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/user_repository.dart';
import 'package:roam_aberdeenshire/domain/shared/domain_error.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/account_recovery_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_email_usecase.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

String email = "foo@bar.com";
Uuid id = Uuid();
AccountRecovery theAccountRecovery = AccountRecovery(email);
User theUser = User(Uuid(), email, "");

class MockAccountRecoveryRepo extends AccountRecoveryRepository {
  @override
  Future<void> create(AccountRecovery obj) {
    return Future.value();
  }
}

class MockAccountRecoveryReturnsErrorRepo extends AccountRecoveryRepository {
  @override
  Future<void> create(AccountRecovery obj) {
    return Future.error("Borked");
  }
}

class MockUserRepo extends UserRepository {
  @override
  Future<User> create(User obj) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(User obj) {
    throw UnimplementedError();
  }

  @override
  Future<List<User>> retrieveBy(Map<String, dynamic> params) {
    if (params["email"] != null) {
      if (params["email"] == theUser.email) {
        return Future.value([theUser]);
      }
      return Future.value(null);
    }
    return Future.value(null);
  }

  @override
  Future<User> retrieveById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> update(User obj) {
    throw UnimplementedError();
  }
}

void main() {
  AccountRecoveryUseCase recoverPasswordUseCase;

  setUp(() {
    recoverPasswordUseCase = AccountRecoveryUseCaseImpl(
        MockUserRepo(), MockAccountRecoveryRepo(), ValidEmailUseCaseImpl());
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
      recoverPasswordUseCase = AccountRecoveryUseCaseImpl(MockUserRepo(),
          MockAccountRecoveryReturnsErrorRepo(), ValidEmailUseCaseImpl());
      result = await recoverPasswordUseCase.recoverPassword(email);
    } catch (error) {
      expect(error, isA<DomainError>());
    }
    expect(result, isNull);
  });
}
