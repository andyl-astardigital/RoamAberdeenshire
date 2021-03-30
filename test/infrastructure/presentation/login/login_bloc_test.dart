import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/authentication_errors.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/domain_error.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/login_usecase.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/login/login_exports.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

String theEmail = "foo@bar.com";
String theInvalidEmail = "foo@bar.";
String thePassword = "!23FooBar-ForMe";
Uuid id = Uuid();
AppUser theUser = AppUser("", theEmail);

class MockLoginUseCaseReturnsUser extends LoginUseCase {
  @override
  Future<AppUser> login(UserCredentials credentials) {
    return Future.value(theUser);
  }
}

class MockLoginUseCaseReturnsNoUserError extends LoginUseCase {
  @override
  Future<AppUser> login(UserCredentials credentials) {
    return Future.error(NoUserFoundError(credentials));
  }
}

class MockLoginUseCaseReturnsDomainError extends LoginUseCase {
  @override
  Future<AppUser> login(UserCredentials credentials) {
    return Future.error(GeneralError(credentials));
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
      LoginErrorState(AuthenticationErrorMessages.noUserFound),
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
      LoginErrorState(GeneralErrorMessages.generalError),
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
