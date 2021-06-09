import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/login_token_usecase.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/shared/ui_constants.dart';
import 'facebook_exports.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

//mocking, we want to inject these things into the bloc so we can unit tests
//without a tedious mocking framework and deep mocking
class FacebookLoginRes {
  final String token;
  final String error;
  final FacebookLoginStatus status;

  FacebookLoginRes(this.token, this.status, this.error);
}

//still mocking
abstract class FacebookLoginWrapper {
  Future<FacebookLoginRes> logIn(List<String> perms);
}

//still bloody mocking
class FacebookLoginWrapperImpl implements FacebookLoginWrapper {
  final FacebookLogin facebookLogin;

  FacebookLoginWrapperImpl(this.facebookLogin);
  Future<FacebookLoginRes> logIn(List<String> perms) async {
    final result = await facebookLogin.logIn(perms);
    return FacebookLoginRes(
        result.accessToken.token, result.status, result.errorMessage);
  }
}

abstract class FacebookBloc extends Bloc<IFacebookEvent, IFacebookState> {
  FacebookBloc(IFacebookState state) : super(state);
}

class FacebookBlocImpl extends FacebookBloc {
  final LoginTokenUseCase loginTokenUseCase;
  final FacebookLoginWrapper facebookLogin;

  FacebookBlocImpl(this.loginTokenUseCase, this.facebookLogin)
      : super(FacebookLoggedOutState());

  @override
  Stream<IFacebookState> mapEventToState(
    IFacebookEvent event,
  ) async* {
    if (event is FacebookLoginEvent) {
      //The FacebookLogin plugin shows UI and returns the token on succesful sign in
      //in our arch we'd split this across the layers but being in a BLoC is better
      //thant nothing!
      try {
        final result = await facebookLogin.logIn(['email']);

        switch (result.status) {
          case FacebookLoginStatus.loggedIn:
            final token = result.token;
            var user = await loginTokenUseCase.login(token, "facebook.com");
            yield FacebookLoggedInState(user);
            break;
          case FacebookLoginStatus.cancelledByUser:
            yield FacebookLoginCancelledState();
            break;
          case FacebookLoginStatus.error:
            yield FacebookErrorState(UIConstants.genericError);
            break;
        }
      } catch (e) {}
    }
  }
}
