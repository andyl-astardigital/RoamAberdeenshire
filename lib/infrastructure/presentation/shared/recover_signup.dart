import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/navigation/navigation_exports.dart';

class RecoverSignupConstants {
  static final Key forgotPasswordButtonKey = Key("btnForgot");
  static final String forgotPassword = "Forgot password?";

  static final Key signupButtonKey = Key("btnSignup");
  static final String signUpLabel = "Signup";

  static final double buttonHeight = 55.0;
}

class RecoverSignup extends StatelessWidget {
  RecoverSignup();
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
                  height: RecoverSignupConstants.buttonHeight,
                  child: TextButton(
                      key: RecoverSignupConstants.forgotPasswordButtonKey,
                      child: Text(
                        RecoverSignupConstants.forgotPassword,
                        textAlign: TextAlign.left,
                      ),
                      onPressed: () {
                        context
                            .read<NavigationBloc>()
                            .add(NavigationShowForgotEvent());
                      }))),
          Expanded(
              flex: 1,
              child: SizedBox(
                  height: RecoverSignupConstants.buttonHeight,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Theme.of(context).accentColor,
                      ),
                      key: RecoverSignupConstants.signupButtonKey,
                      child: Text(
                        RecoverSignupConstants.signUpLabel,
                        textAlign: TextAlign.right,
                      ),
                      onPressed: () {
                        context
                            .read<NavigationBloc>()
                            .add(NavigationShowSignupEvent());
                      })))
        ],
      )
    ]));
  }
}
