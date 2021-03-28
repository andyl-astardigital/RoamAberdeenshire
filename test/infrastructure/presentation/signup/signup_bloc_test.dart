import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/shared/domain_error.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/signup_usecase.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/signup/signup_exports.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

String theEmail = "foo@bar.com";
String theInvalidEmail = "foo@bar.";
String thePassword = "!23FooBar-ForMe";
Uuid id = Uuid();
AppUser theUser = AppUser("", theEmail);

class MockSignupUseCaseReturnsUser extends SignupUseCase {
  @override
  Future<AppUser> signup(UserCredentials credentials) {
    return Future.value(theUser);
  }
}

class MockSignupUseCaseReturnsEmailInUseError extends SignupUseCase {
  @override
  Future<AppUser> signup(UserCredentials credentials) {
    return Future.error(
        EmailInUseError(SignupUseCaseMessages.alreadyInUse, credentials));
  }
}

class MockSignupUseCaseReturnsDomainError extends SignupUseCase {
  @override
  Future<AppUser> signup(UserCredentials credentials) {
    return Future.error(
        DomainError(SignupUseCaseMessages.problem, credentials));
  }
}

void main() {
  SignupBloc signupBloc;

  setUp(() {});

  test('emits SignupValidateState on SignupValidateEvent', () async {
    final expectedResponse = [SignupValidateState(), SignupState()];
    signupBloc = SignupBlocImpl(MockSignupUseCaseReturnsUser());
    expectLater(
      signupBloc.stream,
      emitsInOrder(expectedResponse),
    );

    signupBloc.add(SignupValidateEvent());
  });

  test('emits SignupSuccessfulState on SignupCredentialsValidatedEvent',
      () async {
    final expectedResponse = [SignupSuccessfulState(theUser)];
    signupBloc = SignupBlocImpl(MockSignupUseCaseReturnsUser());
    expectLater(
      signupBloc.stream,
      emitsInOrder(expectedResponse),
    );

    signupBloc.add(SignupCredentialsValidatedEvent(theEmail, thePassword));
  });

  test(
      'emits SignupErrorState on SignupCredentialsValidatedEvent EailInUseError',
      () async {
    final expectedResponse = [
      SignupErrorState(SignupUseCaseMessages.alreadyInUse),
      SignupState()
    ];
    signupBloc = SignupBlocImpl(MockSignupUseCaseReturnsEmailInUseError());
    expectLater(
      signupBloc.stream,
      emitsInOrder(expectedResponse),
    );

    signupBloc.add(SignupCredentialsValidatedEvent(theEmail, thePassword));
  });

  test('emits SignupErrorState on SignupCredentialsValidatedEvent DomainError',
      () async {
    final expectedResponse = [
      SignupErrorState(SignupUseCaseMessages.problem),
      SignupState()
    ];
    signupBloc = SignupBlocImpl(MockSignupUseCaseReturnsDomainError());
    expectLater(
      signupBloc.stream,
      emitsInOrder(expectedResponse),
    );

    signupBloc.add(SignupCredentialsValidatedEvent(theEmail, thePassword));
  });
}
