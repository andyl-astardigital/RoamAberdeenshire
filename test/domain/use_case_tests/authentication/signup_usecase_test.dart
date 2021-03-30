import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/account_repository.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/signup_repository.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/authentication_errors.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/domain_error.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/signup_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_email_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_password_usecase.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

String name = "foo";
String email = "foo@bar.com";
String password = "!23@ForMe";
Uuid id = Uuid();
AppUser theUser = AppUser("", email);

class MockSignupRepo extends SignupRepository {
  @override
  Future<AppUser> create(UserCredentials obj) {
    return Future.value(theUser);
  }
}

class MockAccountRepoWithError extends SignupRepository {
  @override
  Future<AppUser> create(UserCredentials obj) {
    return Future.error(GeneralError(""));
  }
}

class MockAccountRepo extends AccountRepository {
  @override
  Future<List<AppUser>> retrieveBy(Map<String, dynamic> params) {
    return Future.value(null);
  }
}

class MockAccountRepoWithAccount extends AccountRepository {
  @override
  Future<List<AppUser>> retrieveBy(Map<String, dynamic> params) {
    return Future.value([theUser]);
  }
}

void main() {
  SignupUseCase signupUseCase;

  setUp(() {
    signupUseCase = SignupUseCaseImpl(MockSignupRepo(), MockAccountRepo(),
        ValidEmailUseCaseImpl(), ValidPasswordUseCaseImpl());
  });

  test('Signup UseCase returns User when details are valid', () async {
    String newEmail = "foo@bar.com";
    String newPassword = "!2dw33....3@ForMe";
    var result = await signupUseCase
        .signup(UserCredentials(newEmail, password: newPassword));
    expect(result, isNotNull);
  });

  test('Signup UseCase returns error when details are already in use',
      () async {
    AppUser result;
    signupUseCase = SignupUseCaseImpl(
        MockSignupRepo(),
        MockAccountRepoWithAccount(),
        ValidEmailUseCaseImpl(),
        ValidPasswordUseCaseImpl());
    try {
      result = await signupUseCase
          .signup(UserCredentials(email, password: password));
    } catch (error) {
      expect(error, isA<EmailInUseError>());
    }
    expect(result, isNull);
  });

  test('Signup UseCase returns an error when the signup process fails',
      () async {
    signupUseCase = SignupUseCaseImpl(MockAccountRepoWithError(),
        MockAccountRepo(), ValidEmailUseCaseImpl(), ValidPasswordUseCaseImpl());

    AppUser result;
    String email = "a@b.com";
    String password = "!23AbC__";
    try {
      result = await signupUseCase
          .signup(UserCredentials(email, password: password));
    } catch (error) {
      expect(error, isA<GeneralError>());
    }
    expect(result, isNull);
  });
}
