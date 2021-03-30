import 'package:roam_aberdeenshire/infrastructure/presentation/navigation/navigation_exports.dart';
import 'package:test/test.dart';

void main() {
  NavigationBloc navigationBloc;

  setUp(() {
    navigationBloc = NavigationBloc();
  });

  test('emits NavigationShowLoginPageState on NavigationShowLoginPageEvent',
      () async {
    final expectedResponse = [NavigationShowLoginState()];

    expectLater(
      navigationBloc.stream,
      emitsInOrder(expectedResponse),
    );

    navigationBloc.add(NavigationShowLoginEvent());
  });

  test('emits NavigationShowSignupState on NavigationShowSignupPageEvent',
      () async {
    final expectedResponse = [NavigationShowSignupState()];

    expectLater(
      navigationBloc.stream,
      emitsInOrder(expectedResponse),
    );

    navigationBloc.add(NavigationShowSignupEvent());
  });

  test(
      'emits NavigationShowAccountRecoveryState on NavigationShowAccountRecoveryEvent',
      () async {
    final expectedResponse = [NavigationShowAccountRecoveryState()];

    expectLater(
      navigationBloc.stream,
      emitsInOrder(expectedResponse),
    );

    navigationBloc.add(NavigationShowAccountRecoveryEvent());
  });

  test('emits NavigationShowHomePageState on NavigationShowHomePageEvent',
      () async {
    final expectedResponse = [NavigationShowHomeState()];

    expectLater(
      navigationBloc.stream,
      emitsInOrder(expectedResponse),
    );

    navigationBloc.add(NavigationShowHomeEvent());
  });
}
