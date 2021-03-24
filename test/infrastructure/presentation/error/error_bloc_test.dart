import 'package:roam_aberdeenshire/infrastructure/presentation/error/error_exports.dart';
import 'package:test/test.dart';

String theError = "That's right proper borken";

void main() {
  ErrorBloc errorBloc;

  setUp(() {});

  test('emits ErrorHasErrorState on ErrorShowErrorEvent', () async {
    final expectedResponse = [
      ErrorHasErrorState(theError),
      ErrorClearErrorState()
    ];
    errorBloc = ErrorBlocImpl();
    expectLater(
      errorBloc.stream,
      emitsInOrder(expectedResponse),
    );

    errorBloc.add(ErrorShowErrorEvent(theError));
  });
}
