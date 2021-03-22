import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/credentials/credentials_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/login/login_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/shared/recover_signup.dart';

class MockLoginBloc extends LoginBloc {
  MockLoginBloc(ILoginState initialState) : super(initialState);

  @override
  Stream<ILoginState> mapEventToState(ILoginEvent event) {
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

pump(WidgetTester tester, MockLoginBloc mockLoginBloc,
    MockCredentialsBloc mockCredentialsBloc) async {
  await tester.pumpWidget(MultiBlocProvider(providers: [
    BlocProvider<LoginBloc>.value(value: mockLoginBloc),
    BlocProvider<CredentialsBloc>.value(value: mockCredentialsBloc),
  ], child: MaterialApp(home: Scaffold(body: Login()))));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
      'Login shows title/image, email field, password field, sign up button, sign in button, forgot password, twitter login and facebook login',
      (WidgetTester tester) async {
    await pump(tester, MockLoginBloc(LoginState()),
        MockCredentialsBloc(CredentialsState.init()));

    expect(find.byKey(LoginConstants.titleImage), findsOneWidget);
    expect(find.byKey(CredentialsConstants.emailTxtKey), findsOneWidget);
    expect(find.text(CredentialsConstants.emailInvalid), findsNothing);
    expect(find.byKey(CredentialsConstants.passwordTxtKey), findsOneWidget);
    expect(find.byKey(RecoverSignupConstants.forgotPasswordButtonKey),
        findsOneWidget);
    expect(find.byKey(RecoverSignupConstants.signupButtonKey), findsOneWidget);
    expect(find.byKey(LoginConstants.loginButtonKey), findsOneWidget);
    expect(find.byKey(SocialLoginsConstants.twitterButtonKey), findsOneWidget);
    expect(find.byKey(SocialLoginsConstants.facebookButtonKey), findsOneWidget);
  });
}
