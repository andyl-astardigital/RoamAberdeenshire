import 'package:roam_aberdeenshire/domain/entities/user.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/user_repository.dart';
import 'package:roam_aberdeenshire/domain/shared/domain_error.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/login_usecase.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

String name = "foo";
String email = "foo@bar.com";
String password = "!23FooBar-ForMe";
Uuid id = Uuid();
User theUser = User(Uuid(), email, password);

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
    if (params["email"] != null && params["password"] != null) {
      if (params["email"] == theUser.email &&
          params["password"] == theUser.password) {
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

class MockUserRepoWithError extends UserRepository{
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
    return Future.error("Something broke.");
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
  LoginUseCase loginUseCase;

  setUp(() {
    loginUseCase = LoginUseCaseImpl(MockUserRepo());
  });

  test('Login UseCase returns User when details are correct', () async {
    var result = await loginUseCase.login(email, password);

    expect(result, isNotNull);
  });

  test('Login UseCase returns null when details are not correct', () async {
    User result;
    String email = "a@b.com";
    String password = "!23AbC__";
    try {
      result = await loginUseCase.login(email, password);
    } catch (error) {
      expect(error, isA<NoUserFoundError>());
    }
    expect(result, isNull);
  });

  test('Login UseCase returns an error when the login process fails', () async {
    loginUseCase = LoginUseCaseImpl(MockUserRepoWithError());

    User result;
    String email = "a@b.com";
    String password = "!23AbC__";
    try {
      result = await loginUseCase.login(email, password);
    } catch (error) {
      expect(error, isA<DomainError>());
    }
    expect(result, isNull);
  });
}
