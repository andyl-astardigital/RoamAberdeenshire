import 'dart:async';
import 'package:bloc/bloc.dart';
import 'navigation_exports.dart';

class NavigationBloc extends Bloc<INavigationEvent, INavigationState> {
  NavigationBloc() : super(ShowLoginPageState());

  @override
  Stream<INavigationState> mapEventToState(
    INavigationEvent event,
  ) async* {
    if (event is ShowLoginPageEvent) {
      yield ShowLoginPageState();
    }
    if (event is ShowSignupPageEvent) {
      yield ShowSignupPageState();
    }
  }
}
