import 'package:bloc/bloc.dart';
import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/domain_error.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/login_usecase.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/home/home_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/shared/ui_constants.dart';

abstract class HomeBloc extends Bloc<IHomeEvent, IHomeState> {
  HomeBloc(IHomeState state) : super(state);
}

class HomeBlocImpl extends HomeBloc {
  HomeBlocImpl() : super(HomeState());

  @override
  Stream<IHomeState> mapEventToState(
    IHomeEvent event,
  ) async* {
    if (state is HomeState) {
      var theState = state as HomeState;
      // if (event is LoginValidateEvent) {
      //   yield LoginValidateState();
      //   yield theState;
      // }
      yield theState;
    }
  }
}
