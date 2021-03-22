import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/credentials/credentials_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/shared/recover_signup.dart';

import 'login_exports.dart';

class LoginConstants {
  static final Key loginButtonKey = Key("btnLogin");
  static final String loginButtonLabel = "Login";

  static final Key titleImage = Key("imgTitle");

  static final double buttonHeight = 55.0;
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, ILoginState>(
        listener: (context, state) {},
        child: BlocBuilder<LoginBloc, ILoginState>(
          builder: (context, state) {
            if (state is LoginState) {
              return Center(
                  child: Container(
                      padding: EdgeInsets.all(40.0),
                      child: SingleChildScrollView(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                                padding: EdgeInsets.only(bottom: 40),
                                child: Center(
                                    key: LoginConstants.titleImage,
                                    child: Image.asset(
                                        "lib/infrastructure/presentation/resources/RoamABZ.png"))),
                            Credentials(),
                            RecoverSignup(),
                            SizedBox(
                                height: LoginConstants
                                    .buttonHeight, // specific value
                                child: ElevatedButton(
                                    key: LoginConstants.loginButtonKey,
                                    child: Text(LoginConstants.loginButtonLabel,
                                        style: TextStyle(fontSize: 20.0)),
                                    onPressed: () {
                                      context
                                          .read<LoginBloc>()
                                          .add(LoginValidateEvent());
                                    })),
                            SocialLogins(),
                          ],
                        ),
                      )));
            }
            return Container();
          },
        ));
  }
}
