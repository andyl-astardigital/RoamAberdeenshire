import 'dart:async';
import 'package:bloc/bloc.dart';
import 'navigation_exports.dart';

class NavigationBloc extends Bloc<INavigationEvent, INavigationState> {
  NavigationBloc() : super(NavigationShowLoginState());

  @override
  Stream<INavigationState> mapEventToState(
    INavigationEvent event,
  ) async* {
    if (event is NavigationShowLoginEvent) {
      yield NavigationShowLoginState();
    }
    if (event is NavigationShowSignupEvent) {
      yield NavigationShowSignupState();
    }
    if (event is NavigationShowAccountRecoveryEvent) {
      yield NavigationShowAccountRecoveryState();
    }
    if (event is NavigationShowHomeEvent) {
      yield NavigationShowHomeState();
    }
  }
}
