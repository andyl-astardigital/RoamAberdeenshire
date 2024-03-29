import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/authentication_errors.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/domain_error.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/signup_email_password_usecase.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/signup/signup_exports.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

String theEmail = "foo@bar.com";
String theInvalidEmail = "foo@bar.";
String thePassword = "!23FooBar-ForMe";
List<String> providers = ["facebook", "email"];
Uuid id = Uuid();
AppUser theUser = AppUser("", theEmail);

class MockSignupUseCaseReturnsUser extends SignupEmailPasswordUseCase {
  @override
  Future<AppUser> signup(UserCredentials credentials) {
    return Future.value(theUser);
  }
}

class MockSignupUseCaseReturnsEmailInUseError
    extends SignupEmailPasswordUseCase {
  @override
  Future<AppUser> signup(UserCredentials credentials) {
    return Future.error(
        EmailInUsedByOtherProvidersError(credentials.email, providers));
  }
}

class MockSignupUseCaseReturnsDomainError extends SignupEmailPasswordUseCase {
  @override
  Future<AppUser> signup(UserCredentials credentials) {
    return Future.error(GeneralError(credentials));
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
      SignupErrorState(AuthenticationErrorMessages.emailInUseByTheseProviders +
          providers.toString()),
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
      SignupErrorState(GeneralErrorMessages.generalError),
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
