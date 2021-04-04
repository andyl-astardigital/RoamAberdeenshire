import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_exports.dart';

class HomeConstants {
  static final Key loginButtonKey = Key("btnLogin");
  static final String loginButtonLabel = "LOGIN";
  static final double buttonHeight = 55.0;
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, IHomeState>(
        listener: (context, state) {},
        child: BlocBuilder<HomeBloc, IHomeState>(
          builder: (context, state) {
            if (state is HomeState) {
              return Scaffold(
                  appBar: PreferredSize(
                      preferredSize: Size.fromHeight(
                          MediaQuery.of(context).size.height * 0.30),
                      child: Container()),
                  body: Container(
                      padding: EdgeInsets.all(40.0),
                      child: SingleChildScrollView(
                        child: ListView(
                          shrinkWrap: true,
                          children: [Text("Hysies ${state.user.email}!")],
                        ),
                      )));
            }
            return Container();
          },
        ));
  }
}
