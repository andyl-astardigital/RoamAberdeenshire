import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login.dart';

class LoginPageConstants {
  static final String loginButtonLabel = "Login";
  static final Key loginButtonKey = Key("btnLogin");

  static final Key forgotPasswordButtonKey = Key("btnForgot");
  static final String forgotPassword = "Forgot password?";

  static final Key signUpButtonKey = Key("btnSignup");
  static final String signUp = "Signup";

  static final Key titleImage = Key("imgTitle");

  static final double buttonHeight = 55.0;
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, ILoginState>(
        listener: (context, state) {},
        child: BlocBuilder<LoginBloc, ILoginState>(
          builder: (context, state) {
            if (state is LoginState) {
              return Scaffold(
                  body: Center(
                      child: Container(
                          padding: EdgeInsets.all(40.0),
                          child: SingleChildScrollView(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Container(
                                    padding: EdgeInsets.only(bottom: 40),
                                    child: Center(
                                        key: LoginPageConstants.titleImage,
                                        child: Image.asset(
                                            "lib/infrastructure/presentation/resources/RoamABZ.png"))),
                                LoginDetails(),
                                RecoverSignup(),
                                SizedBox(
                                    height: LoginPageConstants
                                        .buttonHeight, // specific value
                                    child: ElevatedButton(
                                        key: LoginPageConstants.loginButtonKey,
                                        child: Text(
                                            LoginPageConstants.loginButtonLabel
                                                .toUpperCase(),
                                            style: TextStyle(fontSize: 20.0)),
                                        onPressed: () {
                                          context
                                              .read<LoginBloc>()
                                              .add(LoggingInEvent());
                                        })),
                                SocialLogins(),
                              ],
                            ),
                          ))));
            }
            return Container();
          },
        ));
  }
}

class RecoverSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: SizedBox(
                  height: LoginPageConstants.buttonHeight,
                  child: TextButton(
                      key: LoginPageConstants.forgotPasswordButtonKey,
                      child: Text(
                        LoginPageConstants.forgotPassword,
                        textAlign: TextAlign.left,
                      ),
                      onPressed: () {
                        //context.read<LoginBloc>().add(LoggingInEvent());
                      }))),
          Expanded(
              flex: 1,
              child: SizedBox(
                  height: LoginPageConstants.buttonHeight,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Theme.of(context).accentColor,
                      ),
                      key: LoginPageConstants.signUpButtonKey,
                      child: Text(
                        LoginPageConstants.signUp,
                        textAlign: TextAlign.right,
                      ),
                      onPressed: () {
                        //context.read<LoginBloc>().add(LoggingInEvent());
                      })))
        ],
      )
    ]));
  }
}

class ErrorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, ILoginState>(
        listener: (context, state) {
          if (state is ErrorState) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Container());
  }
}
