import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login.dart';

class LoginDetailsConstants {
  //login page
  static final Key emailTxtKey = Key("txtEmail");
  static final String emailLabel = "Email";
  static final String emailInvalid = "Email isn't a valid email address";

  static final Key passwordTxtKey = Key("txtPassword");
  static final String passwordLabel = "Password";
  static final String passwordIsMissing = "Password cannot be empty";

}
class LoginDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, ILoginState>(builder: (context, state) {
      if (state is LoginState) {
        return Column(children: <Widget>[
          Center(
              child: Container(
                  child: TextField(
            key: LoginDetailsConstants.emailTxtKey,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) =>
                context.read<LoginBloc>().add(EmailChangedEvent(value)),
            decoration: InputDecoration(
                errorText:
                    state.emailInvalid ? LoginDetailsConstants.emailInvalid : null,
                labelText: LoginDetailsConstants.emailLabel),
          ))),
          Center(
              child: Container(
                  padding: EdgeInsets.only(bottom: 40),
                  child: TextField(
                    obscureText: !state.passwordVisible,
                    key: LoginDetailsConstants.passwordTxtKey,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) => context
                        .read<LoginBloc>()
                        .add(PasswordChangedEvent(value)),
                    decoration: InputDecoration(
                        labelText: LoginDetailsConstants.passwordLabel,
                        errorText: state.passwordIsMissing
                            ? LoginDetailsConstants.passwordIsMissing
                            : null,
                        suffix: InkWell(
                            onTap: () => context
                                .read<LoginBloc>()
                                .add(PasswordVisibilityEvent()),
                            child: Icon(Icons.visibility))),
                  )))
        ]);
      }
      return Container();
    });
  }
}
