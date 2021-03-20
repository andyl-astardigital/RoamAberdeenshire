// import 'package:bloc/bloc.dart';
// import 'package:roam_aberdeenshire/domain/use_cases/authentication/login_usecase.dart';
// import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_email_usecase.dart';
// import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_password_usecase.dart';
// import 'package:roam_aberdeenshire/infrastructure/presentation/login/login.dart';

// abstract class LoginBloc extends Bloc<ILoginEvent, ILoginState> {
//   LoginBloc(ILoginState state) : super(state);
// }

// class LoginBlocImpl extends LoginBloc {
//   LoginUseCase loginuseCase;
//   ValidEmailUseCase vaildEmailUseCase;
//   ValidPasswordUseCase validPasswordUseCase;
//   LoginBlocImpl(
//       this.loginuseCase, this.vaildEmailUseCase, this.validPasswordUseCase)
//       : super(LoginState.init());

//   @override
//   Stream<ILoginState> mapEventToState(
//     ILoginEvent event,
//   ) async* {
//     if (state is LoginState) {
//       var theState = state as LoginState;

//       if (theState.signUpMode) {
//         //sign up specific logic
//         if (event is EmailChangedEvent) {
//           yield theState.copyWith(
//               email: event.email,
//               emailValid: vaildEmailUseCase.validate(event.email));
//         }

//         if (event is PasswordChangedEvent) {
//           yield theState.copyWith(
//               password: event.password,
//               passwordValid: validPasswordUseCase.validate(event.password));
//         }
//       } else {
//         //login specific logic
//         if (event is EmailChangedEvent) {
//           yield theState.copyWith(email: event.email);
//         }
//         if (event is PasswordChangedEvent) {
//           yield theState.copyWith(password: event.password);
//         }
//       }

//       if (event is LoggingInEvent || event is ToggleForgotPasswordModeEvent) {
//         var emailValid = vaildEmailUseCase.validate(theState.email);

//         if (emailValid) {
//           if (event is LoggingInEvent) {
//             yield LoggingInState(theState.email, theState.password);
//           } else {
//             yield ForgotPasswordState(theState.email);
//           }

//           yield theState;
//         }
//         yield theState.copyWith(emailValid: emailValid);
//       }

//       if (event is SigningUpEvent) {
//         var emailValid = vaildEmailUseCase.validate(theState.email);
//         var passwordValid = validPasswordUseCase.validate(theState.password);

//         if (emailValid && passwordValid) {
//           yield SigningUpState(theState.email, theState.password);

//           yield theState;
//         }
//         yield theState.copyWith(
//             emailValid: emailValid, passwordValid: passwordValid);
//       }

//       if (event is PasswordVisibilityEvent) {
//         yield theState.copyWith(passwordVisible: !theState.passwordVisible);
//       }

//       if (event is ToggleSignUpModeEvent) {
//         yield theState.copyWith(
//             signUpMode: !theState.signUpMode,
//             forgotPasswordMode: false,
//             email: "",
//             emailValid: true,
//             password: "",
//             passwordValid: true);
//       }

//       if (event is ToggleForgotPasswordModeEvent) {
//         yield theState.copyWith(
//             forgotPasswordMode: !theState.forgotPasswordMode,
//             signUpMode: false,
//             email: "",
//             emailValid: true,
//             password: "",
//             passwordValid: true);
//       }

//       if (event is AuthErrorEvent) {
//         yield ErrorState(event.error);
//         yield theState;
//       }
//     }
//   }
// }
