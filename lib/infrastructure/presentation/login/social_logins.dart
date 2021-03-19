import 'package:flutter/material.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/shared/ui_constants.dart';

import 'login.dart';

class SocialLoginsConstants {
  static final Key twitterButtonKey = Key("btnTwitter");
  static final String twitterLabel = "Twitter";

  static final Key facebookButtonKey = Key("btnFacebook");
  static final String facebookLabel = "Facebook";

  static final double buttonHeight = 55.0;
}

class SocialLogins extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Text('Or login with', textAlign: TextAlign.center)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: SizedBox(
                      height: SocialLoginsConstants.buttonHeight, // specific value
                      child: Container(
                          padding: EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: UIConstants.twitterColor,
                              ),
                              key: SocialLoginsConstants.twitterButtonKey,
                              child: Text(
                                  SocialLoginsConstants.twitterLabel.toUpperCase(),
                                  style: TextStyle(fontSize: 20.0)),
                              onPressed: () {
                                //context.read<LoginBloc>().add(LoggingInEvent());
                              })))),
              Expanded(
                  flex: 1,
                  child: SizedBox(
                      height: SocialLoginsConstants.buttonHeight, // specific value
                      child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: UIConstants.facebookColor),
                              key: SocialLoginsConstants.facebookButtonKey,
                              child: Text(
                                  SocialLoginsConstants.facebookLabel
                                      .toUpperCase(),
                                  style: TextStyle(fontSize: 20.0)),
                              onPressed: () {
                                //context.read<LoginBloc>().add(LoggingInEvent());
                              }))))
            ],
          )
        ]));
  }
}
