import 'package:roam_aberdeenshire/infrastructure/presentation/navigation/navigation_exports.dart';
import 'package:test/test.dart';

void main() {
  NavigationBloc navigationBloc;

  setUp(() {
    navigationBloc = NavigationBloc();
  });

  test('emits NavigationShowLoginPageEvent on NavigationShowLoginPageEvent',
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
}
