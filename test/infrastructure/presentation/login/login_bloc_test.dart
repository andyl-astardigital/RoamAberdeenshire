import 'package:roam_aberdeenshire/domain/entities/user.dart';
import 'package:roam_aberdeenshire/domain/shared/domain_error.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/login_usecase.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/login/login_exports.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

String theEmail = "foo@bar.com";
String theInvalidEmail = "foo@bar.";
String thePassword = "!23FooBar-ForMe";
Uuid id = Uuid();
User theUser = User(Uuid(), theEmail, thePassword);

class MockLoginUseCaseReturnsUser extends LoginUseCase {
  @override
  Future<User> login(String email, String password) {
    return Future.value(theUser);
  }
}

class MockLoginUseCaseReturnsNoUserError extends LoginUseCase {
  @override
  Future<User> login(String email, String password) {
    return Future.error(
        NoUserFoundError(LoginUseCaseMessages.noAccount, [email, password]));
  }
}

class MockLoginUseCaseReturnsDomainError extends LoginUseCase {
  @override
  Future<User> login(String email, String password) {
    return Future.error(
        DomainError(LoginUseCaseMessages.problem, [email, password]));
  }
}

void main() {
  LoginBloc loginBloc;

  setUp(() {});

  test('emits LoginValidateState on LoginValidateEvent', () async {
    final expectedResponse = [LoginValidateState(), LoginState()];
    loginBloc = LoginBlocImpl(MockLoginUseCaseReturnsUser());
    expectLater(
      loginBloc.stream,
      emitsInOrder(expectedResponse),
    );

    loginBloc.add(LoginValidateEvent());
  });

  test('emits LoginSuccessfulState on LoginCredentialsValidatedEvent',
      () async {
    final expectedResponse = [LoginSuccessfulState(theUser)];
    loginBloc = LoginBlocImpl(MockLoginUseCaseReturnsUser());
    expectLater(
      loginBloc.stream,
      emitsInOrder(expectedResponse),
    );

    loginBloc.add(LoginCredentialsValidatedEvent(theEmail, thePassword));
  });

  test('emits LoginErrorState on LoginCredentialsValidatedEvent NoUserError',
      () async {
    final expectedResponse = [
      LoginErrorState(LoginUseCaseMessages.noAccount),
      LoginState()
    ];
    loginBloc = LoginBlocImpl(MockLoginUseCaseReturnsNoUserError());
    expectLater(
      loginBloc.stream,
      emitsInOrder(expectedResponse),
    );

    loginBloc.add(LoginCredentialsValidatedEvent(theEmail, thePassword));
  });

  test('emits LoginErrorState on LoginCredentialsValidatedEvent DomainError',
      () async {
    final expectedResponse = [
      LoginErrorState(LoginUseCaseMessages.problem),
      LoginState()
    ];
    loginBloc = LoginBlocImpl(MockLoginUseCaseReturnsDomainError());
    expectLater(
      loginBloc.stream,
      emitsInOrder(expectedResponse),
    );

    loginBloc.add(LoginCredentialsValidatedEvent(theEmail, thePassword));
  });
}
