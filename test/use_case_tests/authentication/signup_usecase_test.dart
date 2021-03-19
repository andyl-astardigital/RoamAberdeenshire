import 'package:roam_aberdeenshire/domain/entities/user.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/user_repository.dart';
import 'package:roam_aberdeenshire/domain/shared/domain_error.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/signup_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_email_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_password_usecase.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

String name = "foo";
String email = "foo@bar.com";
String password = "!23@ForMe";
Uuid id = Uuid();
User theUser = User(Uuid(), email, password);

class MockUserRepo extends UserRepository {
  @override
  Future<User> create(User obj) {
    if (obj != null) {
      if (obj.id != null && obj.email != null && obj.password != null) {
        return Future.value(obj);
      }
      return Future.error(DomainError("broken", obj));
    }
    return Future.error(DomainError("broken", obj));
  }

  @override
  Future<void> delete(User obj) {
    throw UnimplementedError();
  }

  @override
  Future<List<User>> retrieveBy(Map<String, dynamic> params) {
    if (params["email"] == theUser.email &&
        params["password"] == theUser.password) {
      return Future.value([theUser]);
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

class MockUserRepoWithError extends UserRepository {
  @override
  Future<User> create(User obj) {
    return Future.error(DomainError("broken", obj));
  }

  @override
  Future<void> delete(User obj) {
    throw UnimplementedError();
  }

  @override
  Future<List<User>> retrieveBy(Map<String, dynamic> params) {
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
  SignupUseCase signupUseCase;

  setUp(() {
    signupUseCase = SignupUseCaseImpl(
        MockUserRepo(), ValidEmailUseCaseImpl(), ValidPasswordUseCaseImpl());
  });

  test('Signup UseCase returns User when details are valid', () async {
    String newEmail = "foo@bar.com";
    String newPassword = "!2dw33....3@ForMe";
    var result = await signupUseCase.signup(newEmail, newPassword);
    expect(result, isNotNull);
  });

  test('Signup UseCase returns error when details are already in use',
      () async {
    User result;
    try {
      result = await signupUseCase.signup(email, password);
    } catch (error) {
      expect(error, isA<EmailInUseError>());
    }
    expect(result, isNull);
  });

  test('Signup UseCase returns an error when the signup process fails',
      () async {
    signupUseCase = SignupUseCaseImpl(MockUserRepoWithError(),
        ValidEmailUseCaseImpl(), ValidPasswordUseCaseImpl());

    User result;
    String email = "a@b.com";
    String password = "!23AbC__";
    try {
      result = await signupUseCase.signup(email, password);
    } catch (error) {
      expect(error, isA<DomainError>());
    }
    expect(result, isNull);
  });
}
