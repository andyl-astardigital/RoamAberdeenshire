import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/credentials/credentials_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/signup/signup_exports.dart';

class MockSignupBloc extends SignupBloc {
  MockSignupBloc(ISignupState initialState) : super(initialState);

  @override
  Stream<ISignupState> mapEventToState(ISignupEvent event) {
    throw UnimplementedError();
  }
}

class MockCredentialsBloc extends CredentialsBloc {
  MockCredentialsBloc(ICredentialsState initialState) : super(initialState);

  @override
  Stream<ICredentialsState> mapEventToState(ICredentialsEvent event) {
    throw UnimplementedError();
  }
}

pump(WidgetTester tester, MockSignupBloc mockSignupBloc,
    MockCredentialsBloc mockCredentialsBloc) async {
  await tester.pumpWidget(MultiBlocProvider(providers: [
    BlocProvider<SignupBloc>.value(value: mockSignupBloc),
    BlocProvider<CredentialsBloc>.value(value: mockCredentialsBloc),
  ], child: MaterialApp(home: Scaffold(body: Signup()))));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
      'Signup shows title/image, email field, password field, sign up button and login button',
      (WidgetTester tester) async {
    await pump(tester, MockSignupBloc(SignupState()),
        MockCredentialsBloc(CredentialsState.init()));

    expect(find.byKey(SignupConstants.titleImage), findsOneWidget);
    expect(find.byKey(CredentialsConstants.emailTxtKey), findsOneWidget);
    expect(find.text(CredentialsConstants.emailInvalid), findsNothing);
    expect(find.byKey(CredentialsConstants.passwordTxtKey), findsOneWidget);
    expect(find.byKey(SignupConstants.loginButtonKey), findsOneWidget);
    expect(find.byKey(SignupConstants.signupButtonKey), findsOneWidget);
  });
}
