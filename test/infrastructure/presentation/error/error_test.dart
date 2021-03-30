import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/error/app_error_exports.dart';

class MockErrorBloc extends AppErrorBloc {
  MockErrorBloc(IAppErrorState initialState) : super(initialState);

  @override
  Stream<IAppErrorState> mapEventToState(IAppErrorEvent event) async* {
    yield AppErrorHasErrorState((event as AppErrorShowErrorEvent).error);
  }
}

pump(WidgetTester tester, MockErrorBloc mockErrorBloc) async {
  await tester.pumpWidget(MultiBlocProvider(providers: [
    BlocProvider<AppErrorBloc>.value(value: mockErrorBloc),
  ], child: MaterialApp(home: Scaffold(body: AppError()))));
  await tester.pumpAndSettle();
}

String theError = "That's right proper borken";

void main() {
  testWidgets('Error shows an error', (WidgetTester tester) async {
    var mockErrorBloc = MockErrorBloc(AppErrorClearErrorState());
    await pump(tester, mockErrorBloc);
    mockErrorBloc.add(AppErrorShowErrorEvent(theError));

    await tester.pumpAndSettle(); // schedule animation
    expect(find.text(theError), findsOneWidget);
  });
}
