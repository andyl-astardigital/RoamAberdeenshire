import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/login_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/signup_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_email_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_password_usecase.dart';
import 'package:roam_aberdeenshire/infrastructure/data/firebase_user_repository.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/credentials/credentials_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/shared/theme.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/signup/signup_exports.dart';
import 'error/error_exports.dart';
import 'login/login_exports.dart';
import 'navigation/navigation_exports.dart';
import 'shared/ui_constants.dart';

class SimpleBlocObserver extends BlocObserver {
  AnsiPen greenPen = new AnsiPen()..green(bold: true);
  AnsiPen bluePen = new AnsiPen()..blue(bold: true);
  AnsiPen redPen = new AnsiPen()..red(bold: true);
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(greenPen("Event") + event.toString());
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(bluePen("Transtion") + transition.toString());
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(redPen("Error") + "${bloc.toString()}  ${error.toString()}");
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();

  Widget buildBlocs() {
    //instatiate

    var navigationBloc = NavigationBloc();
    var loginBloc = LoginBlocImpl(LoginUseCaseImpl(FirebaseUserRepository()));
    var credentialsBloc = CredentialsBlocImpl(
        ValidEmailUseCaseImpl(), ValidPasswordUseCaseImpl());
    var signupBloc = SignupBlocImpl(SignupUseCaseImpl(FirebaseUserRepository(),
        ValidEmailUseCaseImpl(), ValidPasswordUseCaseImpl()));
    var errorBloc = ErrorBlocImpl();

    loginBloc.stream.listen((state) {
      if (state is LoginValidateState) {
        credentialsBloc.add(CredentialsValidateLoginEvent());
      }
      if (state is LoginErrorState) {
        errorBloc.add(ErrorShowErrorEvent(state.error));
      }
    });

    signupBloc.stream.listen((state) {
      if (state is SignupValidateState) {
        credentialsBloc.add(CredentialsValidateSignupEvent());
      }
      if (state is SignupErrorState) {
        errorBloc.add(ErrorShowErrorEvent(state.error));
      }
    });

    credentialsBloc.stream.listen((state) {
      if (state is CredentialsValidSignupState) {
        signupBloc
            .add(SignupCredentialsValidatedEvent(state.email, state.password));
      }
      if (state is CredentialsValidLoginState) {
        loginBloc
            .add(LoginCredentialsValidatedEvent(state.email, state.password));
      }
    });

    navigationBloc.stream.listen((state) {
      if (state is NavigationShowLoginState) {
        credentialsBloc.add(CredentialsResetValidationEvent());
      }
      if (state is NavigationShowSignupState) {
        credentialsBloc.add(CredentialsResetValidationEvent());
      }
    });
    //plumb into flutter_bloc providers
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (context) {
            return navigationBloc;
          },
        ),
        BlocProvider<LoginBloc>(
          create: (context) {
            return loginBloc;
          },
        ),
        BlocProvider<CredentialsBloc>(
          create: (context) {
            return credentialsBloc;
          },
        ),
        BlocProvider<SignupBloc>(
          create: (context) {
            return signupBloc;
          },
        ),
        BlocProvider<ErrorBloc>(
          create: (context) {
            return errorBloc;
          },
        ),
      ],
      child: MyApp(),
    );
  }

  runApp(buildBlocs());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);
  final loginPage = Login();
  getNav(INavigationState state) {
    if (state is NavigationShowLoginState) {
      return Login();
    }
    if (state is NavigationShowSignupState) {
      return Signup();
    }
    if (state is NavigationShowForgotPasswordState) {
      return Container();
    }
    if (state is NavigationShowHomeState) {
      return Container();
    }
    return Login();
  }

  @override
  Widget build(BuildContext context) {
    context.read<NavigationBloc>().add(NavigationShowLoginEvent());
    return MaterialApp(
        title: UIConstants.appTitle,
        debugShowCheckedModeBanner: false,
        theme: myTheme,
        home: BlocBuilder<NavigationBloc, INavigationState>(
            builder: (context, state) {
          return BlocBuilder<LoginBloc, ILoginState>(
              builder: (context, loginState) {
            return Scaffold(body: Stack(children: [getNav(state), Error()]));
          });
        }));
  }
}
