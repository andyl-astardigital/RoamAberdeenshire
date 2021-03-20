// import 'package:roam_aberdeenshire/domain/entities/user.dart';
// import 'package:roam_aberdeenshire/domain/use_cases/authentication/login_usecase.dart';
// import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_email_usecase.dart';
// import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_password_usecase.dart';
// import 'package:roam_aberdeenshire/infrastructure/presentation/login/login.dart';
// import 'package:test/test.dart';
// import 'package:uuid/uuid.dart';

// String email = "foo@bar.com";
// String invalidEmail = "foo@bar.";
// String password = "!23FooBar-ForMe";
// Uuid id = Uuid();
// User theUser = User(Uuid(), email, password);

// class MockLoginUseCase extends LoginUseCase {
//   @override
//   Future<User> login(String email, String password) {
//     // TODO: implement login
//     throw UnimplementedError();
//   }
// }

// void main() {
//   LoginBloc loginBloc;

//   setUp(() {
//     loginBloc = LoginBlocImpl(MockLoginUseCase(), ValidEmailUseCaseImpl(),
//         ValidPasswordUseCaseImpl());
//   });

//   test('emits email state on EmailChangedEvent', () async {
//     final expectedResponse = [LoginState.init(email: email)];

//     expectLater(
//       loginBloc.stream,
//       emitsInOrder(expectedResponse),
//     );

//     loginBloc.add(EmailChangedEvent(email));
//   });

//   test('emits password state on PasswordChangedEvent', () async {
//     final expectedResponse = [LoginState.init(password: password)];

//     expectLater(
//       loginBloc.stream,
//       emitsInOrder(expectedResponse),
//     );

//     loginBloc.add(PasswordChangedEvent(password));
//   });

//   test('emits sign up mode state on ToggleSignUpModeEvent', () async {
//     final expectedResponse = [LoginState.init(signUpMode: true)];

//     expectLater(
//       loginBloc.stream,
//       emitsInOrder(expectedResponse),
//     );

//     loginBloc.add(ToggleSignUpModeEvent());
//   });

//   group('LoginBloc, login mode', () {
//     group('input events', () {
//       test('emits email invalid state on invalid email entry', () async {
//         final expectedResponse = [
//           LoginState.init(email: invalidEmail),
//           LoginState.init(email: invalidEmail, emailValid: false)
//         ];

//         expectLater(
//           loginBloc.stream,
//           emitsInOrder(expectedResponse),
//         );

//         loginBloc.add(EmailChangedEvent(invalidEmail));
//         loginBloc.add(LoggingInEvent());
//       });
//     });

//     group('button events', () {});
//   });

//   group('LoginBloc, sign up mode', () {
//     group('input events', () {
//       test('emits email invalid state on invalid email entry', () async {
//         final expectedResponse = [
//           LoginState.init(signUpMode: true),
//           LoginState.init(
//               signUpMode: true, email: invalidEmail, emailValid: false)
//         ];

//         expectLater(
//           loginBloc.stream,
//           emitsInOrder(expectedResponse),
//         );
//         loginBloc.add(ToggleSignUpModeEvent());
//         loginBloc.add(EmailChangedEvent(invalidEmail));
//       });

//       test('emits password invalid state on invalid password entry', () async {
//         final expectedResponse = [
//           LoginState.init(signUpMode: true),
//           LoginState.init(
//               signUpMode: true, password: "ddd", passwordValid: false)
//         ];

//         expectLater(
//           loginBloc.stream,
//           emitsInOrder(expectedResponse),
//         );
//         loginBloc.add(ToggleSignUpModeEvent());
//         loginBloc.add(PasswordChangedEvent("ddd"));
//       });

//       test('emits email invalid state on invalid sign up details', () async {
//         final expectedResponse = [
//           LoginState.init(passwordValid: false, emailValid: false)
//         ];

//         expectLater(
//           loginBloc.stream,
//           emitsInOrder(expectedResponse),
//         );

//         loginBloc.add(SigningUpEvent());
//       });
//     });

//     group('button events', () {});
//   });
// }
