import 'package:bloc/bloc.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/home/home_exports.dart';

abstract class HomeBloc extends Bloc<IHomeEvent, IHomeState> {
  HomeBloc(IHomeState state) : super(state);
}

class HomeBlocImpl extends HomeBloc {
  HomeBlocImpl() : super(HomeNoUserState());

  @override
  Stream<IHomeState> mapEventToState(
    IHomeEvent event,
  ) async* {
    if (event is HomeUserUpdatedEvent) {
      yield HomeState(event.user);
    }
    if (state is HomeState) {
      var theState = state as HomeState;
      yield theState;
    }
  }
}
