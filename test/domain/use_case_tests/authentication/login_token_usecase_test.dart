import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/token_login_respository.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/authentication_errors.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/domain_error.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/account_providers_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/login_token_usecase.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

String name = "foo";
String email = "foo@bar.com";
String password = "!23FooBar-ForMe";
String token = "ImAToken";
Uuid id = Uuid();
AppUser theUser = AppUser("", email);

class MockAccountProvidersUseCaseFacebook extends AccountProvidersUseCase {
  @override
  Future<List<String>> getProviders(String email) {
    return Future.value(["facebook.com"]);
  }
}

class MockAccountProvidersUseCaseEmail extends AccountProvidersUseCase {
  @override
  Future<List<String>> getProviders(String email) {
    return Future.value(["email"]);
  }
}

class MockAccountProvidersUseCaseNone extends AccountProvidersUseCase {
  @override
  Future<List<String>> getProviders(String email) {
    return Future.value([]);
  }
}

class MockTokenLoginRepository extends TokenLoginRepository {
  @override
  Future<AppUser> create(String obj) {
    return Future.value(theUser); 
  }
}

class MockTokenLoginRepositoryError extends TokenLoginRepository {
  @override
  Future<AppUser> create(String obj) {
    return Future.error(GeneralError("")); 
  }
}

void main() {
  LoginTokenUseCase loginUseCase;

  setUp(() {});

  test('Login Token UseCase returns User when details are correct', () async {
    loginUseCase = LoginTokenUseCaseImpl(
        MockTokenLoginRepository(), MockAccountProvidersUseCaseFacebook());
    var result = await loginUseCase.login(token, "facebook.com");
    expect(result, isNotNull);
  });

  test(
      'Login Token UseCase returns error when details are already in use by other provider',
      () async {
    AppUser result;
    loginUseCase = LoginTokenUseCaseImpl(
        MockTokenLoginRepository(), MockAccountProvidersUseCaseEmail());
    try {
      result = await loginUseCase.login(token, "facebook.com");
    } catch (error) {
      expect(error, isA<EmailInUsedByOtherProvidersError>());
      expect((error as EmailInUsedByOtherProvidersError).providers,
          equals(["email"]));
    }
    expect(result, isNull);
  });

  test('Login Token UseCase returns an error when the login process fails', () async {
    loginUseCase = LoginTokenUseCaseImpl(
        MockTokenLoginRepositoryError(), MockAccountProvidersUseCaseEmail());

    AppUser result;
    
    try {
      result = await loginUseCase.login(token, "email");
    } catch (error) {
      expect(error, isA<GeneralError>());
    }
    expect(result, isNull);
  });
}
