import 'package:bloc/bloc.dart';
import '../app_error_exports.dart';

abstract class AppErrorBloc extends Bloc<IAppErrorEvent, IAppErrorState> {
  AppErrorBloc(IAppErrorState state) : super(state);
}

class AppErrorBlocImpl extends AppErrorBloc {
  AppErrorBlocImpl() : super(AppErrorClearErrorState());

  @override
  Stream<IAppErrorState> mapEventToState(
    IAppErrorEvent event,
  ) async* {
    if (event is AppErrorShowErrorEvent) {
      yield AppErrorHasErrorState(event.error);
    }
    yield AppErrorClearErrorState();
  }
}
