import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'error_exports.dart';

class Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ErrorBloc, IErrorState>(
        listener: (context, state) {
          if (state is ErrorHasErrorState) {
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
