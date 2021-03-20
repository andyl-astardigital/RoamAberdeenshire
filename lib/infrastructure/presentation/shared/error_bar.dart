import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/navigation/navigation_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/navigation/navigation_bloc.dart';

class ErrorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, INavigationState>(
        listener: (context, state) {
          if (state is ShowErrorState) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Container());
  }
}
