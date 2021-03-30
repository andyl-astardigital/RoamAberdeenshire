import 'package:ansicolor/ansicolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/account_recovery_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/login_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/signup_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_email_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_password_usecase.dart';
import 'package:roam_aberdeenshire/infrastructure/data/firebase_account_recovery_repository.dart';
import 'package:roam_aberdeenshire/infrastructure/data/firebase_account_repository.dart';
import 'package:roam_aberdeenshire/infrastructure/data/firebase_login_repository.dart';
import 'package:roam_aberdeenshire/infrastructure/data/firebase_signup_repository.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/credentials/credentials_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/home/home_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/shared/theme.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/signup/signup_exports.dart';
import 'error/app_error_exports.dart';
import 'login/login_exports.dart';
import 'account_recovery/account_recovery_exports.dart';
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
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();

  Widget buildBlocs() {
    //instatiate
    var loginRepository = FirebaseLoginRepository();
    var signupRepository = FirebaseSignupRepository();
    var accountRepository = FirebaseAccountRepository();
    var accountRecoveryRepository = FirebaseAccountRecoveryRepository();

    var navigationBloc = NavigationBloc();
    var loginBloc = LoginBlocImpl(LoginUseCaseImpl(loginRepository));

    var credentialsBloc = CredentialsBlocImpl(
        ValidEmailUseCaseImpl(), ValidPasswordUseCaseImpl());

    var signupBloc = SignupBlocImpl(SignupUseCaseImpl(
        signupRepository,
        accountRepository,
        ValidEmailUseCaseImpl(),
        ValidPasswordUseCaseImpl()));

    var errorBloc = AppErrorBlocImpl();

    var accountRecoveryBloc = AccountRecoveryBlocImpl(
        AccountRecoveryUseCaseImpl(accountRepository, accountRecoveryRepository,
            ValidEmailUseCaseImpl()));

    var homeBloc = HomeBlocImpl();

    loginBloc.stream.listen((state) {
      if (state is LoginValidateState) {
        credentialsBloc.add(CredentialsValidateLoginEvent());
      }
      if (state is LoginErrorState) {
        errorBloc.add(AppErrorShowErrorEvent(state.error));
      }
      if (state is LoginSuccessfulState) {
        navigationBloc.add(NavigationShowHomeEvent());
      }
    });

    signupBloc.stream.listen((state) {
      if (state is SignupValidateState) {
        credentialsBloc.add(CredentialsValidateSignupEvent());
      }
      if (state is SignupErrorState) {
        errorBloc.add(AppErrorShowErrorEvent(state.error));
      }
      if (state is SignupSuccessfulState) {
        navigationBloc.add(NavigationShowHomeEvent());
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
            return navigationBloc..add(NavigationShowLoginEvent());
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
        BlocProvider<AccountRecoveryBloc>(
          create: (context) {
            return accountRecoveryBloc;
          },
        ),
        BlocProvider<AppErrorBloc>(
          create: (context) {
            return errorBloc;
          },
        ),
        BlocProvider<HomeBloc>(
          create: (context) {
            return homeBloc;
          },
        ),
      ],
      child: MyApp(),
    );
  }

  runApp(buildBlocs());
}

class MyApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:

  MyApp({Key key}) : super(key: key);
  final loginPage = Login();

  doNav(INavigationState state, BuildContext context) {
    Widget page;
    if (state is NavigationShowLoginState) {
      page = Login();
    } else if (state is NavigationShowSignupState) {
      page = Signup();
    } else if (state is NavigationShowAccountRecoveryState) {
      page = AccountRecovery();
    } else if (state is NavigationShowHomeState) {
      page = Home();
    } else
      page = Login();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return page;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: UIConstants.appTitle,
        debugShowCheckedModeBanner: false,
        theme: myTheme,
        home: BlocListener<NavigationBloc, INavigationState>(
            listener: (context, state) {
          doNav(state, context);
        }, child: BlocBuilder<NavigationBloc, INavigationState>(
                builder: (context, state) {
          return Login();
        })));
  }
}
