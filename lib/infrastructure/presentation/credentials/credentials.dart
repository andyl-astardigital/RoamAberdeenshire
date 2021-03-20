import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/credentials/credentials_exports.dart';

class CredentialsConstants {
  //login page
  static final Key emailTxtKey = Key("txtEmail");
  static final String emailLabel = "Email";
  static final String emailInvalid = "Email isn't a valid email address";

  static final Key passwordTxtKey = Key("txtPassword");
  static final String passwordLabel = "Password";
  static final String passwordInvalid = "Password not strong enough";
}

class Credentials extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CredentialsBloc, ICredentialsState>(
        builder: (context, state) {
      if (state is CredentialsState) {
        return Column(children: <Widget>[
          Center(
              child: Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    key: CredentialsConstants.emailTxtKey,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => context
                        .read<CredentialsBloc>()
                        .add(EmailChangedEvent(value)),
                    decoration: InputDecoration(
                        errorText: state.emailValid
                            ? null
                            : CredentialsConstants.emailInvalid,
                        labelText: CredentialsConstants.emailLabel),
                  ))),
          Center(
              child: Container(
                  padding: EdgeInsets.only(bottom: 40),
                  child: TextField(
                    obscureText: !state.passwordVisible,
                    key: CredentialsConstants.passwordTxtKey,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) => context
                        .read<CredentialsBloc>()
                        .add(PasswordChangedEvent(value)),
                    decoration: InputDecoration(
                        labelText: CredentialsConstants.passwordLabel,
                        errorText: state.passwordValid
                            ? null
                            : CredentialsConstants.passwordInvalid,
                        suffix: InkWell(
                            onTap: () => context
                                .read<CredentialsBloc>()
                                .add(TogglePasswordVisibilityEvent()),
                            child: Icon(Icons.visibility))),
                  )))
        ]);
      }
      return Container();
    });
  }
}
