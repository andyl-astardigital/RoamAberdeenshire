import 'dart:async';
import 'package:bloc/bloc.dart';
import 'authentication.dart';

class AuthenticationBloc
    extends Bloc<IAuthenticationEvent, IAuthenticationState> {
  

  AuthenticationBloc()
      : super(NotSignedInState());

  @override
  Stream<IAuthenticationState> mapEventToState(
    IAuthenticationEvent event,
  ) async* {
    if (event is AppStartedEvent) {      
      yield NotSignedInState();
    }

    if (event is LoginAttemptEvent) {
      
    }

    if (event is PasswordAddedEvent) {
      
    }

    if (event is SignOutEvent) {
      
    }

    if (event is SignInErrorEvent) {
      
    }

    if (event is SignedInEvent) {
      
    }
  }
}
