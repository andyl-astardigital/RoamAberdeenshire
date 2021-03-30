import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/login_respository.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/authentication_errors.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/domain_error.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/login_usecase.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

String name = "foo";
String email = "foo@bar.com";
String password = "!23FooBar-ForMe";
Uuid id = Uuid();
AppUser theUser = AppUser("", email);

class MockLoginRepo extends LoginRepository {
  @override
  Future<AppUser> create(UserCredentials obj) {
    return Future.value(theUser);
  }
}

class MockLoginRepoWithNoUserError extends LoginRepository {
  @override
  Future<AppUser> create(UserCredentials obj) {
    return Future.value(null);
  }
}

class MockLoginRepoWithGeneralError extends LoginRepository {
  @override
  Future<AppUser> create(UserCredentials obj) {
    return Future.error(GeneralError(""));
  }
}

void main() {
  LoginUseCase loginUseCase;

  setUp(() {
    loginUseCase = LoginUseCaseImpl(MockLoginRepo());
  });

  test('Login UseCase returns User when details are correct', () async {
    var result =
        await loginUseCase.login(UserCredentials(email, password: password));

    expect(result, isNotNull);
  });

  test('Login UseCase returns null when details are not correct', () async {
    AppUser result;
    String email = "a@b.com";
    String password = "!23AbC__";
    loginUseCase = LoginUseCaseImpl(MockLoginRepoWithNoUserError());
    try {
      result =
          await loginUseCase.login(UserCredentials(email, password: password));
    } catch (error) {
      expect(error, isA<NoUserFoundError>());
    }
    expect(result, isNull);
  });

  test('Login UseCase returns an error when the login process fails', () async {
    loginUseCase = LoginUseCaseImpl(MockLoginRepoWithGeneralError());

    AppUser result;
    String email = "a@b.com";
    String password = "!23AbC__";
    try {
      result =
          await loginUseCase.login(UserCredentials(email, password: password));
    } catch (error) {
      expect(error, isA<GeneralError>());
    }
    expect(result, isNull);
  });
}
