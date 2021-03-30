import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/credentials/credentials_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/error/app_error_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/navigation/navigation_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/shared/image_appbar.dart';

import 'signup_exports.dart';

class SignupConstants {
  static final Key signupButtonKey = Key("btnSingup");
  static final String signupButtonLabel = "SIGNUP";

  static final Key loginButtonKey = Key("btnLogin");
  static final String loginButtonLabel = "Login";

  static final Key titleImage = Key("imgTitle");

  static final double buttonHeight = 55.0;
}

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, ISignupState>(
        listener: (context, state) {},
        child: BlocBuilder<SignupBloc, ISignupState>(
          builder: (context, state) {
            if (state is SignupState) {
              return Scaffold(
                  appBar: PreferredSize(
                      preferredSize: Size.fromHeight(
                          MediaQuery.of(context).size.height * 0.30),
                      child: ImageAppBar()),
                  body: Container(
                      padding: EdgeInsets.all(40.0),
                      child: SingleChildScrollView(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Credentials(),
                            SizedBox(
                                height: SignupConstants.buttonHeight,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Theme.of(context).accentColor,
                                    ),
                                    key: SignupConstants.loginButtonKey,
                                    child: Text(
                                      SignupConstants.loginButtonLabel,
                                      textAlign: TextAlign.right,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<NavigationBloc>()
                                          .add(NavigationShowLoginEvent());
                                    })),
                            SizedBox(
                                height: SignupConstants
                                    .buttonHeight, // specific value
                                child: ElevatedButton(
                                    key: SignupConstants.signupButtonKey,
                                    child: Text(
                                        SignupConstants.signupButtonLabel,
                                        style: TextStyle(fontSize: 20.0)),
                                    onPressed: () {
                                      context
                                          .read<SignupBloc>()
                                          .add(SignupValidateEvent());
                                    })),
                            AppError()
                          ],
                        ),
                      )));
            }
            return Container();
          },
        ));
  }
}
