import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/credentials/credentials_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/error/app_error_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/shared/image_appbar.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/shared/recover_signup.dart';

import 'login_exports.dart';

class LoginConstants {
  static final Key loginButtonKey = Key("btnLogin");
  static final String loginButtonLabel = "LOGIN";
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
