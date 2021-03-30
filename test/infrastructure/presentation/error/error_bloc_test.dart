import 'package:roam_aberdeenshire/infrastructure/presentation/error/app_error_exports.dart';
import 'package:test/test.dart';

String theError = "That's right proper borken";

void main() {
  AppErrorBloc errorBloc;

  setUp(() {});

  test('emits ErrorHasErrorState on ErrorShowErrorEvent', () async {
    final expectedResponse = [
      AppErrorHasErrorState(theError),
      AppErrorClearErrorState()
    ];
    errorBloc = AppErrorBlocImpl();
    expectLater(
      errorBloc.stream,
      emitsInOrder(expectedResponse),
    );

    errorBloc.add(AppErrorShowErrorEvent(theError));
  });
}
