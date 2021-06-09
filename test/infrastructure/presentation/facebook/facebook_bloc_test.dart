import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/login_token_usecase.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/facebook/facebook_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/shared/ui_constants.dart';
import 'package:test/test.dart';

final String id = "12345";
final String token = "ascbasdla";
final String email = "a@b.com";
final user = AppUser(id, email);

class MockLoginTokenWithUser extends LoginTokenUseCase {
  @override
  Future<AppUser> login(String token, String provider) {
    return Future.value(user);
  }
}

class MockFacebookLoginWrapper extends FacebookLoginWrapper {
  @override
  Future<FacebookLoginRes> logIn(List<String> perms) {
    return Future.value(
        FacebookLoginRes(token, FacebookLoginStatus.loggedIn, ""));
  }
}

class MockFacebookLoginWrapperCancelled extends FacebookLoginWrapper {
  @override
  Future<FacebookLoginRes> logIn(List<String> perms) {
    return Future.value(
        FacebookLoginRes(token, FacebookLoginStatus.cancelledByUser, ""));
  }
}

class MockFacebookLoginWrapperWithError extends FacebookLoginWrapper {
  @override
  Future<FacebookLoginRes> logIn(List<String> perms) {
    return Future.value(
        FacebookLoginRes(token, FacebookLoginStatus.error, "nope"));
  }
}

void main() {
  FacebookBloc facebookBloc;

  test('emits FacebookLoginEvent on FacebookLoggedInState', () async {
    facebookBloc =
        FacebookBlocImpl(MockLoginTokenWithUser(), MockFacebookLoginWrapper());

    final expectedResponse = [FacebookLoggedInState(user)];

    expectLater(
      facebookBloc.stream,
      emitsInOrder(expectedResponse),
    );

    facebookBloc.add(FacebookLoginEvent());
  });

  test('emits FacebookLoginEvent on FacebookLoginCancelledState', () async {
    facebookBloc = FacebookBlocImpl(
        MockLoginTokenWithUser(), MockFacebookLoginWrapperCancelled());

    final expectedResponse = [FacebookLoginCancelledState()];

    expectLater(
      facebookBloc.stream,
      emitsInOrder(expectedResponse),
    );

    facebookBloc.add(FacebookLoginEvent());
  });

  test('emits FacebookErrorState on FacebookLoginCancelledState', () async {
    facebookBloc = FacebookBlocImpl(
        MockLoginTokenWithUser(), MockFacebookLoginWrapperWithError());

    final expectedResponse = [FacebookErrorState(UIConstants.genericError)];

    expectLater(
      facebookBloc.stream,
      emitsInOrder(expectedResponse),
    );

    facebookBloc.add(FacebookLoginEvent());
  });
}
