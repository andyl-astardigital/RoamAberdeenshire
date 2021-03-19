import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/login_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_email_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_password_usecase.dart';
import 'package:roam_aberdeenshire/infrastructure/data/firebase_user_repository.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/shared/theme.dart';
import 'authentication/authentication.dart';
import 'login/login.dart';
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

    var authBloc = AuthenticationBloc();
    var loginBloc = LoginBlocImpl(LoginUseCaseImpl(FirebaseUserRepository()),
        ValidEmailUseCaseImpl(), ValidPasswordUseCaseImpl());

    //wire up the listeners
    authBloc.stream.listen((state) {
      if (state is AuthErrorState) {
        loginBloc.add(AuthErrorEvent(state.error));
      }
    });

    loginBloc.stream.listen((state) {
      if (state is LoggingInState) {
        //check if this is a new email
        authBloc.add(LoginAttemptEvent(state.email));
      }
    });

    //plumb into flutter_bloc providers
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) {
            return authBloc;
          },
        ),
        BlocProvider<LoginBloc>(
          create: (context) {
            return loginBloc;
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
  final loginPage = LoginPage();

  @override
  Widget build(BuildContext context) {
    context.read<AuthenticationBloc>().add(AppStartedEvent());
    return MaterialApp(
        title: UIConstants.appTitle,
        debugShowCheckedModeBanner: false,
        theme: myTheme,
        home: BlocBuilder<AuthenticationBloc, IAuthenticationState>(
            builder: (context, authState) {
          return BlocBuilder<LoginBloc, ILoginState>(
              builder: (context, loginState) {
            try {
              if (authState is NotSignedInState) {
                return LoginPage();
              } else if (authState is SignedInState) {
                return Container();
              }
              return LoginPage();
            } catch (e) {
              // ScaffoldMessenger().ScaffoldMessenger.showSnackBar(
              //   SnackBar(
              //     content: Text('${e.toString()}'),
              //     backgroundColor: Colors.red,
              //   ),
              // );
            }
            return Container();
          });
        }));
  }
}
