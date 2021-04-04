import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/token_login_respository.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/facebook/facebook_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/shared/ui_constants.dart';
import 'package:test/test.dart';

final String id = "12345";
final String token = "ascbasdla";
final String email = "a@b.com";
final user = AppUser(id, email);

class MockTokenRespositoryWithUser extends TokenLoginRepository {
  @override
  Future<AppUser> create(String obj) {
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
    facebookBloc = FacebookBlocImpl(
        MockTokenRespositoryWithUser(), MockFacebookLoginWrapper());

    final expectedResponse = [FacebookLoggedInState(user)];

    expectLater(
      facebookBloc.stream,
      emitsInOrder(expectedResponse),
    );

    facebookBloc.add(FacebookLoginEvent());
  });

  test('emits FacebookLoginEvent on FacebookLoginCancelledState', () async {
    facebookBloc = FacebookBlocImpl(
        MockTokenRespositoryWithUser(), MockFacebookLoginWrapperCancelled());

    final expectedResponse = [FacebookLoginCancelledState()];

    expectLater(
      facebookBloc.stream,
      emitsInOrder(expectedResponse),
    );

    facebookBloc.add(FacebookLoginEvent());
  });

  test('emits FacebookErrorState on FacebookLoginCancelledState', () async {
    facebookBloc = FacebookBlocImpl(
        MockTokenRespositoryWithUser(), MockFacebookLoginWrapperWithError());

    final expectedResponse = [FacebookErrorState(UIConstants.genericError)];

    expectLater(
      facebookBloc.stream,
      emitsInOrder(expectedResponse),
    );

    facebookBloc.add(FacebookLoginEvent());
  });
}
