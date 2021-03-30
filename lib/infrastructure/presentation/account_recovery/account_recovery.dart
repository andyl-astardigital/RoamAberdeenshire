import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/credentials/credentials_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/error/app_error_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/navigation/navigation_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/shared/image_appbar.dart';

import 'account_recovery_exports.dart';

class AccountRecoveryConstants {
  static final Key sendButtonKey = Key("btnSend");
  static final String signupButtonLabel = "RESET PASSWORD";

  static final Key loginButtonKey = Key("btnLogin");
  static final String loginButtonLabel = "Login";

  static final Key titleImage = Key("imgTitle");

  static final double buttonHeight = 55.0;
}

class AccountRecovery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountRecoveryBloc, IAccountRecoveryState>(
        listener: (context, state) {},
        child: BlocBuilder<AccountRecoveryBloc, IAccountRecoveryState>(
          builder: (context, state) {
            if (state is AccountRecoveryState) {
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
                                height: AccountRecoveryConstants.buttonHeight,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Theme.of(context).accentColor,
                                    ),
                                    key:
                                        AccountRecoveryConstants.loginButtonKey,
                                    child: Text(
                                      AccountRecoveryConstants.loginButtonLabel,
                                      textAlign: TextAlign.right,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<NavigationBloc>()
                                          .add(NavigationShowLoginEvent());
                                    })),
                            SizedBox(
                                height: AccountRecoveryConstants
                                    .buttonHeight, // specific value
                                child: ElevatedButton(
                                    key: AccountRecoveryConstants.sendButtonKey,
                                    child: Text(
                                        AccountRecoveryConstants
                                            .signupButtonLabel,
                                        style: TextStyle(fontSize: 20.0)),
                                    onPressed: () {
                                      context
                                          .read<AccountRecoveryBloc>()
                                          .add(AccountRecoveryValidateEvent());
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
