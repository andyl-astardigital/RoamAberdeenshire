import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/credentials/credentials_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/account_recovery/account_recovery_exports.dart';

class MockAccountRecoveryBloc extends AccountRecoveryBloc {
  MockAccountRecoveryBloc(IAccountRecoveryState initialState)
      : super(initialState);

  @override
  Stream<IAccountRecoveryState> mapEventToState(IAccountRecoveryEvent event) {
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

pump(WidgetTester tester, MockAccountRecoveryBloc mockSignupBloc,
    MockCredentialsBloc mockCredentialsBloc) async {
  await tester.pumpWidget(MultiBlocProvider(providers: [
    BlocProvider<AccountRecoveryBloc>.value(value: mockSignupBloc),
    BlocProvider<CredentialsBloc>.value(value: mockCredentialsBloc),
  ], child: MaterialApp(home: Scaffold(body: AccountRecovery()))));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
      'Signup shows title/image, email field, reset password button and login button',
      (WidgetTester tester) async {
    await pump(tester, MockAccountRecoveryBloc(AccountRecoveryState()),
        MockCredentialsBloc(CredentialsState.init()));

    expect(find.byKey(AccountRecoveryConstants.titleImage), findsOneWidget);
    expect(find.byKey(CredentialsConstants.emailTxtKey), findsOneWidget);
    expect(find.text(CredentialsConstants.emailInvalid), findsNothing);
    expect(find.byKey(CredentialsConstants.passwordTxtKey), findsOneWidget);
    expect(find.byKey(AccountRecoveryConstants.loginButtonKey), findsOneWidget);
    expect(find.byKey(AccountRecoveryConstants.sendButtonKey), findsOneWidget);
  });
}
