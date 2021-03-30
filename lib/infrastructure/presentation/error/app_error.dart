import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_error_exports.dart';

class AppError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppErrorBloc, IAppErrorState>(
        listener: (context, state) {
          if (state is AppErrorHasErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
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
