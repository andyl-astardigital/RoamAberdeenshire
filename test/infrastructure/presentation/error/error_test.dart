import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/error/error_exports.dart';

class MockErrorBloc extends ErrorBloc {
  MockErrorBloc(IErrorState initialState) : super(initialState);

  @override
  Stream<IErrorState> mapEventToState(IErrorEvent event) async* {
    yield ErrorHasErrorState((event as ErrorShowErrorEvent).error);
  }
}

pump(WidgetTester tester, MockErrorBloc mockErrorBloc) async {
  await tester.pumpWidget(MultiBlocProvider(providers: [
    BlocProvider<ErrorBloc>.value(value: mockErrorBloc),
  ], child: MaterialApp(home: Scaffold(body: Error()))));
  await tester.pumpAndSettle();
}

String theError = "That's right proper borken";

void main() {
  testWidgets('Error shows an error', (WidgetTester tester) async {
    var mockErrorBloc = MockErrorBloc(ErrorClearErrorState());
    await pump(tester, mockErrorBloc);
    mockErrorBloc.add(ErrorShowErrorEvent(theError));

    await tester.pumpAndSettle(); // schedule animation
    expect(find.text(theError), findsOneWidget);
  });
}
