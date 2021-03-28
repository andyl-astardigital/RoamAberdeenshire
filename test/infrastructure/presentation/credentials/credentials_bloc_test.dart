import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_email_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_password_usecase.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/credentials/credentials_exports.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

import 'credentials_test.dart';

String theEmail = "foo@bar.com";
String theInvalidEmail = "foobar123";
String thePassword = "!23FooBar-ForMe";
Uuid id = Uuid();
AppUser theUser = AppUser("", theEmail);

void main() {
  CredentialsBloc signupBloc;

  test('emits CredentialsState on CredentialsEmailChangedEvent', () async {
    final expectedResponse = [CredentialsState.init(email: theEmail)];
    signupBloc = CredentialsBlocImpl(
        ValidEmailUseCaseImpl(), ValidPasswordUseCaseImpl());
    expectLater(
      signupBloc.stream,
      emitsInOrder(expectedResponse),
    );

    signupBloc.add(CredentialsEmailChangedEvent(theEmail));
  });

  test('emits CredentialsState on CredentialsPasswordChangedEvent', () async {
    final expectedResponse = [CredentialsState.init(password: thePassword)];
    signupBloc = CredentialsBlocImpl(
        ValidEmailUseCaseImpl(), ValidPasswordUseCaseImpl());
    expectLater(
      signupBloc.stream,
      emitsInOrder(expectedResponse),
    );

    signupBloc.add(CredentialsPasswordChangedEvent(thePassword));
  });

  test('emits CredentialsState on CredentialsToggleValidateOnEntryEvent ',
      () async {
    final expectedResponse = [
      CredentialsState.init(validateOnEntry: true),
      CredentialsState.init(validateOnEntry: false)
    ];
    signupBloc = CredentialsBlocImpl(
        ValidEmailUseCaseImpl(), ValidPasswordUseCaseImpl());
    expectLater(
      signupBloc.stream,
      emitsInOrder(expectedResponse),
    );

    signupBloc.add(CredentialsToggleValidateOnEntryEvent());
    signupBloc.add(CredentialsToggleValidateOnEntryEvent());
  });

  test('emits CredentialsState on CredentialsTogglePasswordVisibilityEvent',
      () async {
    final expectedResponse = [
      CredentialsState.init(passwordVisible: true),
      CredentialsState.init(passwordVisible: false)
    ];
    signupBloc = CredentialsBlocImpl(
        ValidEmailUseCaseImpl(), ValidPasswordUseCaseImpl());
    expectLater(
      signupBloc.stream,
      emitsInOrder(expectedResponse),
    );

    signupBloc.add(CredentialsTogglePasswordVisibilityEvent());
    signupBloc.add(CredentialsTogglePasswordVisibilityEvent());
  });

  test(
      'emits CredentialsValidLoginState & CredentialsState on succesful CredentialsValidateLoginEvents',
      () async {
    final expectedResponse = [
      CredentialsState.init(email: theEmail),
      CredentialsState.init(email: theEmail, password: thePassword),
      CredentialsValidLoginState.init(email: theEmail, password: thePassword),
      CredentialsState.init(
          email: theEmail,
          password: thePassword,
          emailValid: true,
          passwordValid: true),
    ];
    signupBloc = CredentialsBlocImpl(
        ValidEmailUseCaseImpl(), ValidPasswordUseCaseImpl());
    expectLater(
      signupBloc.stream,
      emitsInOrder(expectedResponse),
    );
    signupBloc.add(CredentialsEmailChangedEvent(theEmail));
    signupBloc.add(CredentialsPasswordChangedEvent(thePassword));
    signupBloc.add(CredentialsValidateLoginEvent());
  });

  test('emits CredentialsState on failed CredentialsValidateLoginEvents',
      () async {
    final expectedResponse = [
      CredentialsState.init(email: theInvalidEmail),
      CredentialsState.init(email: theInvalidEmail, emailValid: false),
    ];
    signupBloc = CredentialsBlocImpl(
        ValidEmailUseCaseImpl(), ValidPasswordUseCaseImpl());
    expectLater(
      signupBloc.stream,
      emitsInOrder(expectedResponse),
    );
    signupBloc.add(CredentialsEmailChangedEvent(theInvalidEmail));
    signupBloc.add(CredentialsValidateLoginEvent());
  });

  test(
      'emits CredentialsValidSignupState & CredentialsState on succesful CredentialsValidateSignupEvent',
      () async {
    final expectedResponse = [
      CredentialsState.init(validateOnEntry: true),
      CredentialsState.init(validateOnEntry: true, email: theEmail),
      CredentialsState.init(
          validateOnEntry: true, email: theEmail, password: thePassword),
      CredentialsValidSignupState.init(email: theEmail, password: thePassword),
      CredentialsState.init(
          validateOnEntry: true,
          email: theEmail,
          password: thePassword,
          emailValid: true,
          passwordValid: true),
    ];
    signupBloc = CredentialsBlocImpl(
        ValidEmailUseCaseImpl(), ValidPasswordUseCaseImpl());
    expectLater(
      signupBloc.stream,
      emitsInOrder(expectedResponse),
    );
    signupBloc.add(CredentialsToggleValidateOnEntryEvent());
    signupBloc.add(CredentialsEmailChangedEvent(theEmail));
    signupBloc.add(CredentialsPasswordChangedEvent(thePassword));
    signupBloc.add(CredentialsValidateSignupEvent());
  });

  test('emits CredentialsState on failed CredentialsValidateSignupEvent',
      () async {
    final expectedResponse = [
      CredentialsState.init(validateOnEntry: true),
      CredentialsState.init(
          validateOnEntry: true, email: theInvalidEmail, emailValid: false),
      CredentialsState.init(
          validateOnEntry: true,
          email: theInvalidEmail,
          password: theInvalidPassword,
          emailValid: false,
          passwordValid: false),
    ];
    //NOTE: there is actually one more state emitted but becasue it's identical to the previous one
    //it's ignored by the BLoCs stream. It's there in case someone tries to call the sign in event
    //without having first set the validate on entry (not likely)

    signupBloc = CredentialsBlocImpl(
        ValidEmailUseCaseImpl(), ValidPasswordUseCaseImpl());
    expectLater(
      signupBloc.stream,
      emitsInOrder(expectedResponse),
    );
    signupBloc.add(CredentialsToggleValidateOnEntryEvent());
    signupBloc.add(CredentialsEmailChangedEvent(theInvalidEmail));
    signupBloc.add(CredentialsPasswordChangedEvent(theInvalidPassword));
    signupBloc.add(CredentialsValidateSignupEvent());
  });
}
