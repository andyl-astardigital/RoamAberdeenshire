import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/authentication_errors.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/domain_error.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/account_recovery_usecase.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/account_recovery/account_recovery_exports.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

String theEmail = "foo@bar.com";
String theInvalidEmail = "foo@bar.";
String thePassword = "!23FooBar-ForMe";
Uuid id = Uuid();
AppUser theUser = AppUser("", theEmail);

class MockAccountRecoveryUseCaseReturnsBool extends AccountRecoveryUseCase {
  @override
  Future<bool> recoverPassword(String email) {
    return Future.value(true);
  }
}

class MockAccountRecoveryUseCaseReturnsNoUserFoundError
    extends AccountRecoveryUseCase {
  @override
  Future<bool> recoverPassword(String email) {
    return Future.error(NoUserFoundError(UserCredentials(email, password: "")));
  }
}

class MockAccountRecoveryUseCaseReturnsDomainError
    extends AccountRecoveryUseCase {
  @override
  Future<bool> recoverPassword(String email) {
    return Future.error(GeneralError(email));
  }
}

void main() {
  AccountRecoveryBloc signupBloc;

  setUp(() {});

  test('emits AccountRecoveryValidateState on AccountRecoveryValidateEvent',
      () async {
    final expectedResponse = [
      AccountRecoveryValidateState(),
      AccountRecoveryState()
    ];
    signupBloc =
        AccountRecoveryBlocImpl(MockAccountRecoveryUseCaseReturnsBool());
    expectLater(
      signupBloc.stream,
      emitsInOrder(expectedResponse),
    );

    signupBloc.add(AccountRecoveryValidateEvent());
  });

  test(
      'emits AccountRecoverySuccessfulState on AccountRecoveryCredentialsValidatedEvent',
      () async {
    final expectedResponse = [AccountRecoverySuccessfulState()];
    signupBloc =
        AccountRecoveryBlocImpl(MockAccountRecoveryUseCaseReturnsBool());
    expectLater(
      signupBloc.stream,
      emitsInOrder(expectedResponse),
    );

    signupBloc.add(AccountRecoveryCredentialsValidatedEvent(theEmail));
  });

  test(
      'emits AccountRecoveryErrorState on AccountRecoveryCredentialsValidatedEvent NoAccountError',
      () async {
    final expectedResponse = [
      AccountRecoveryErrorState(AuthenticationErrorMessages.noUserFound),
      AccountRecoveryState()
    ];
    signupBloc = AccountRecoveryBlocImpl(
        MockAccountRecoveryUseCaseReturnsNoUserFoundError());
    expectLater(
      signupBloc.stream,
      emitsInOrder(expectedResponse),
    );

    signupBloc.add(AccountRecoveryCredentialsValidatedEvent(theEmail));
  });

  test('emits SignupErrorState on SignupCredentialsValidatedEvent DomainError',
      () async {
    final expectedResponse = [
      AccountRecoveryErrorState(GeneralErrorMessages.generalError),
      AccountRecoveryState()
    ];
    signupBloc =
        AccountRecoveryBlocImpl(MockAccountRecoveryUseCaseReturnsDomainError());
    expectLater(
      signupBloc.stream,
      emitsInOrder(expectedResponse),
    );

    signupBloc.add(AccountRecoveryCredentialsValidatedEvent(theEmail));
  });
}
