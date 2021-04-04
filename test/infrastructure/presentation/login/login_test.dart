import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/credentials/credentials_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/error/app_error_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/facebook/facebook_bloc.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/facebook/facebook_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/login/login_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/shared/image_appbar.dart';
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

class MockAppErrorBloc extends AppErrorBloc {
  MockAppErrorBloc(IAppErrorState initialState) : super(initialState);

  @override
  Stream<IAppErrorState> mapEventToState(IAppErrorEvent event) {
    throw UnimplementedError();
  }
}

class MockFacebookBloc extends FacebookBloc {
  MockFacebookBloc(IFacebookState initialState) : super(initialState);

  @override
  Stream<IFacebookState> mapEventToState(IFacebookEvent event) {
    throw UnimplementedError();
  }
}

pump(
    WidgetTester tester,
    MockLoginBloc mockLoginBloc,
    MockCredentialsBloc mockCredentialsBloc,
    MockAppErrorBloc mockAppErrorBloc,
    MockFacebookBloc mockFacebookBloc) async {
  await tester.pumpWidget(MultiBlocProvider(providers: [
    BlocProvider<LoginBloc>.value(value: mockLoginBloc),
    BlocProvider<CredentialsBloc>.value(value: mockCredentialsBloc),
    BlocProvider<AppErrorBloc>.value(value: mockAppErrorBloc),
    BlocProvider<FacebookBloc>.value(value: mockFacebookBloc),
  ], child: MaterialApp(home: Scaffold(body: Login()))));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
      'Login shows title/image, email field, password field, sign up button, sign in button, forgot password and facebook login',
      (WidgetTester tester) async {
    await pump(
        tester,
        MockLoginBloc(LoginState()),
        MockCredentialsBloc(CredentialsState.init()),
        MockAppErrorBloc(AppErrorClearErrorState()),
        MockFacebookBloc(FacebookLoggedOutState()));

    expect(find.byKey(ImageAppBarConstants.titleImage), findsOneWidget);
    expect(find.byKey(CredentialsConstants.emailTxtKey), findsOneWidget);
    expect(find.text(CredentialsConstants.emailInvalid), findsNothing);
    expect(find.byKey(CredentialsConstants.passwordTxtKey), findsOneWidget);
    expect(find.byKey(RecoverSignupConstants.forgotPasswordButtonKey),
        findsOneWidget);
    expect(find.byKey(RecoverSignupConstants.signupButtonKey), findsOneWidget);
    expect(find.byKey(LoginConstants.loginButtonKey), findsOneWidget);
    //expect(find.byKey(SocialLoginsConstants.twitterButtonKey), findsOneWidget);
    expect(find.byKey(SocialLoginsConstants.facebookButtonKey), findsOneWidget);
    expect(find.byType(AppError), findsOneWidget);
  });
}
