// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:roam_aberdeenshire/infrastructure/presentation/shared/credentials.dart';

// import '../login/login.dart';

// class SignupPageConstants {
//   static final String signupButtonLabel = "Signup";
//   static final Key signupButtonKey = Key("btnSignup");

//   static final Key backButtonKey = Key("btnBack");
//   static final String backButtonLabel = "Back";

//   static final Key titleImage = Key("imgTitle");

//   static final double buttonHeight = 55.0;
// }

// class SignupPage extends StatelessWidget {
//   String primaryLabel(LoginState state) {
//     if (state.signUpMode) return LoginPageConstants.signUpLabel;
//     if (state.forgotPasswordMode) return LoginPageConstants.resetButtonLabel;
//     return LoginPageConstants.loginButtonLabel;
//   }

//   String secondaryLabel(LoginState state) {
//     if (state.signUpMode) return LoginPageConstants.loginButtonLabel;
//     if (state.forgotPasswordMode) return LoginPageConstants.backButtonLabel;
//     return LoginPageConstants.signUpLabel;
//   }

//   void primaryAction(LoginState state, BuildContext context) {
//     if (state.signUpMode) context.read<LoginBloc>().add(SigningUpEvent());
//     if (state.forgotPasswordMode)
//       context.read<LoginBloc>().add(ToggleForgotPasswordEvent());
//     if (!state.signUpMode) context.read<LoginBloc>().add(LoggingInEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<LoginBloc, ILoginState>(
//         listener: (context, state) {},
//         child: BlocBuilder<LoginBloc, ILoginState>(
//           builder: (context, state) {
//             if (state is LoginState) {
//               return Scaffold(
//                   body: Center(
//                       child: Container(
//                           padding: EdgeInsets.all(40.0),
//                           child: SingleChildScrollView(
//                             child: ListView(
//                               shrinkWrap: true,
//                               children: [
//                                 Container(
//                                     padding: EdgeInsets.only(bottom: 40),
//                                     child: Center(
//                                         key: LoginPageConstants.titleImage,
//                                         child: Image.asset(
//                                             "lib/infrastructure/presentation/resources/RoamABZ.png"))),
//                                 Credentials(),
//                                 SizedBox(
//                                     height: LoginPageConstants
//                                         .buttonHeight, // specific value
//                                     child: ElevatedButton(
//                                         key:
//                                             LoginPageConstants.loginButtonKey,
//                                         child: Text(primaryLabel(state),
//                                             style: TextStyle(fontSize: 20.0)),
//                                         onPressed: () {
//                                           primaryAction(state, context);
//                                         })),
//                               ],
//                             ),
//                           ))));
//             }
//             return Container();
//           },
//         ));
//   }
// }
