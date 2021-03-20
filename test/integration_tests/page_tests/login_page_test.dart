// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:roam_aberdeenshire/infrastructure/presentation/login/login.dart';
// import 'package:roam_aberdeenshire/infrastructure/presentation/shared/credentials.dart';

// class MockLoginBloc extends LoginBloc {
//   MockLoginBloc(ILoginState initialState) : super(initialState);

//   @override
//   Stream<ILoginState> mapEventToState(ILoginEvent event) {
//     // TODO: implement mapEventToState
//     throw UnimplementedError();
//   }
// }

// pump(WidgetTester tester, MockLoginBloc mockLoginBloc) async {
//   await tester.pumpWidget(MultiBlocProvider(providers: [
//     BlocProvider<LoginBloc>.value(value: mockLoginBloc),
//   ], child: MaterialApp(home: LoginPage())));
//   await tester.pumpAndSettle();
// }

// void main() {
//   group('Login page default', () {
//     testWidgets(
//         'shows title/image, email field, password field, sign up button, sign in button, forgot password, twitter login and facebook login',
//         (WidgetTester tester) async {
//       await pump(tester, MockLoginBloc(LoginState.init()));

//       expect(find.byKey(LoginPageConstants.titleImage), findsOneWidget);
//       expect(find.byKey(CredentialsConstants.emailTxtKey), findsOneWidget);
//       expect(find.text(CredentialsConstants.emailInvalid), findsNothing);
//       expect(find.byKey(CredentialsConstants.passwordTxtKey), findsOneWidget);
//       expect(find.byKey(LoginPageConstants.forgotPasswordButtonKey),
//           findsOneWidget);
//       expect(find.byKey(LoginPageConstants.signupButtonKey), findsOneWidget);
//       expect(find.byKey(LoginPageConstants.loginButtonKey), findsOneWidget);
//       expect(
//           find.byKey(SocialLoginsConstants.twitterButtonKey), findsOneWidget);
//       expect(
//           find.byKey(SocialLoginsConstants.facebookButtonKey), findsOneWidget);
//     });
//   });

//   group('Login page credential feedback', () {
//     testWidgets('shows warning if email is invalid',
//         (WidgetTester tester) async {
//       await pump(tester, MockLoginBloc(LoginState.init(emailValid: false)));

//       var emailTextField = find
//           .byKey(CredentialsConstants.emailTxtKey)
//           .evaluate()
//           .single
//           .widget as TextField;

//       expect(emailTextField.decoration.errorText,
//           CredentialsConstants.emailInvalid);
//     });

//     testWidgets('shows no warning if email is valid',
//         (WidgetTester tester) async {
//       await pump(tester, MockLoginBloc(LoginState.init(emailValid: true)));

//       var emailTextField = find
//           .byKey(CredentialsConstants.emailTxtKey)
//           .evaluate()
//           .single
//           .widget as TextField;
//       expect(emailTextField.decoration.errorText, null);
//     });

//     testWidgets('shows warning if password is invalid',
//         (WidgetTester tester) async {
//       await pump(tester, MockLoginBloc(LoginState.init(passwordValid: false)));

//       var emailTextField = find
//           .byKey(CredentialsConstants.passwordTxtKey)
//           .evaluate()
//           .single
//           .widget as TextField;
//       expect(emailTextField.decoration.errorText,
//           CredentialsConstants.passwordInvalid);
//     });
//   });

//   group('Login page navigation', () {
//     testWidgets('opens signup page', (WidgetTester tester) async {
//       //TODO
//     });
//     testWidgets('opens forgot password page', (WidgetTester tester) async {
//       //TODO
//     });
//     testWidgets('opens Twitter login', (WidgetTester tester) async {
//       //ToDo
//     });

//     testWidgets('opens Facebook login', (WidgetTester tester) async {
//       //ToDo
//     });
//   });

//   group('Login page sign up mode', () {
//     testWidgets(
//         'shows title/image, email field, password field, signup button, login button',
//         (WidgetTester tester) async {
//       await pump(tester, MockLoginBloc(LoginState.init(signUpMode: true)));

//       expect(find.byKey(LoginPageConstants.titleImage), findsOneWidget);
//       expect(find.byKey(CredentialsConstants.emailTxtKey), findsOneWidget);
//       expect(find.text(CredentialsConstants.emailInvalid), findsNothing);
//       expect(find.byKey(CredentialsConstants.passwordTxtKey), findsOneWidget);
//       expect(find.text(CredentialsConstants.passwordInvalid), findsNothing);
//       expect(
//           find.byKey(LoginPageConstants.forgotPasswordButtonKey), findsNothing);
//       expect(find.byKey(LoginPageConstants.signupButtonKey), findsOneWidget);
//       expect(find.byKey(LoginPageConstants.loginButtonKey), findsOneWidget);
//       expect(find.byKey(SocialLoginsConstants.twitterButtonKey), findsNothing);
//       expect(find.byKey(SocialLoginsConstants.facebookButtonKey), findsNothing);
//     });
//   });
// }
