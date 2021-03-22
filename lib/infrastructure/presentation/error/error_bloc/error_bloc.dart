import 'package:bloc/bloc.dart';
import '../error_exports.dart';

abstract class ErrorBloc extends Bloc<IErrorEvent, IErrorState> {
  ErrorBloc(IErrorState state) : super(state);
}

class ErrorBlocImpl extends ErrorBloc {
  ErrorBlocImpl() : super(ErrorClearErrorState());

  @override
  Stream<IErrorState> mapEventToState(
    IErrorEvent event,
  ) async* {
    if (event is ErrorShowErrorEvent) {
      yield ErrorHasErrorState(event.error);
    }
    yield ErrorClearErrorState();
  }
}
