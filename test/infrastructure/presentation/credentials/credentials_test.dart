import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/credentials/credentials_exports.dart';

class MockCredentialsBloc extends CredentialsBloc {
  MockCredentialsBloc(ICredentialsState initialState) : super(initialState);

  @override
  Stream<ICredentialsState> mapEventToState(ICredentialsEvent event) async* {
    yield state;
  }
}

String theEmail = "foo@bar.com";
String theInvalidEmail = "foo@bar.";
String thePassword = "!23FooBar-ForMe";
String theInvalidPassword = "1234";

pump(WidgetTester tester, MockCredentialsBloc mockCredentialsBloc) async {
  await tester.pumpWidget(MultiBlocProvider(providers: [
    BlocProvider<CredentialsBloc>.value(value: mockCredentialsBloc),
  ], child: MaterialApp(home: Scaffold(body: Credentials()))));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Credentials shows email field and password field',
      (WidgetTester tester) async {
    await pump(tester, MockCredentialsBloc(CredentialsState.init()));

    expect(find.byKey(CredentialsConstants.emailTxtKey), findsOneWidget);
    expect(find.text(CredentialsConstants.emailInvalid), findsNothing);
    expect(find.byKey(CredentialsConstants.passwordTxtKey), findsOneWidget);
    expect(find.text(CredentialsConstants.passwordInvalid), findsNothing);
  });

  testWidgets('Credentials shows email', (WidgetTester tester) async {
    await pump(
        tester, MockCredentialsBloc(CredentialsState.init(email: theEmail)));

    expect(find.text(theEmail), findsOneWidget);
  });

  testWidgets('Credentials shows password', (WidgetTester tester) async {
    await pump(tester,
        MockCredentialsBloc(CredentialsState.init(password: thePassword)));

    expect(find.text(thePassword), findsOneWidget);
  });

  testWidgets('Credentials shows email error', (WidgetTester tester) async {
    await pump(
        tester, MockCredentialsBloc(CredentialsState.init(emailValid: false)));

    expect(find.text(CredentialsConstants.emailInvalid), findsOneWidget);
    expect(find.text(CredentialsConstants.passwordInvalid), findsNothing);
  });

  testWidgets('Credentials shows password error', (WidgetTester tester) async {
    await pump(tester,
        MockCredentialsBloc(CredentialsState.init(passwordValid: false)));

    expect(find.text(CredentialsConstants.emailInvalid), findsNothing);
    expect(find.text(CredentialsConstants.passwordInvalid), findsOneWidget);
  });

  testWidgets('Credentials obscures password text',
      (WidgetTester tester) async {
    await pump(
        tester,
        MockCredentialsBloc(
            CredentialsState.init(email: theEmail, passwordVisible: false)));
    expect(
        (find.byKey(CredentialsConstants.passwordTxtKey).evaluate().first.widget
                as TextField)
            .obscureText,
        true);
  });

  testWidgets('Credentials unobscures password text',
      (WidgetTester tester) async {
    await pump(
        tester,
        MockCredentialsBloc(
            CredentialsState.init(email: theEmail, passwordVisible: true)));
    expect(
        (find.byKey(CredentialsConstants.passwordTxtKey).evaluate().first.widget
                as TextField)
            .obscureText,
        false);
  });
}
