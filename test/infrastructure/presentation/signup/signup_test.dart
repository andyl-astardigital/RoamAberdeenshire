import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/credentials/credentials_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/error/app_error_exports.dart';
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

class MockAppErrorBloc extends AppErrorBloc {
  MockAppErrorBloc(IAppErrorState initialState) : super(initialState);

  @override
  Stream<IAppErrorState> mapEventToState(IAppErrorEvent event) {
    throw UnimplementedError();
  }
}

pump(
    WidgetTester tester,
    MockSignupBloc mockSignupBloc,
    MockCredentialsBloc mockCredentialsBloc,
    MockAppErrorBloc mockAppErrorBloc) async {
  await tester.pumpWidget(MultiBlocProvider(providers: [
    BlocProvider<SignupBloc>.value(value: mockSignupBloc),
    BlocProvider<CredentialsBloc>.value(value: mockCredentialsBloc),
    BlocProvider<AppErrorBloc>.value(value: mockAppErrorBloc),
  ], child: MaterialApp(home: Scaffold(body: Signup()))));
  await tester.pumpAndSettle();
}

String theError = "it's borke";
void main() {
  testWidgets(
      'Signup shows title/image, email field, password field, sign up button and login button',
      (WidgetTester tester) async {
    await pump(
      tester,
      MockSignupBloc(SignupState()),
      MockCredentialsBloc(CredentialsState.init()),
      MockAppErrorBloc(AppErrorClearErrorState()),
    );

    expect(find.byKey(SignupConstants.titleImage), findsOneWidget);
    expect(find.byKey(CredentialsConstants.emailTxtKey), findsOneWidget);
    expect(find.text(CredentialsConstants.emailInvalid), findsNothing);
    expect(find.byKey(CredentialsConstants.passwordTxtKey), findsOneWidget);
    expect(find.byKey(SignupConstants.loginButtonKey), findsOneWidget);
    expect(find.byKey(SignupConstants.signupButtonKey), findsOneWidget);
    expect(find.byType(AppError), findsOneWidget);
  });
}
