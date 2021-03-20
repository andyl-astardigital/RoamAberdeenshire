import 'package:bloc/bloc.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/login_usecase.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/login/login_exports.dart';

abstract class LoginBloc extends Bloc<ILoginEvent, ILoginState> {
  LoginBloc(ILoginState state) : super(state);
}

class LoginBlocImpl extends LoginBloc {
  final LoginUseCase loginuseCase;

  LoginBlocImpl(this.loginuseCase) : super(LoginState());

  @override
  Stream<ILoginState> mapEventToState(
    ILoginEvent event,
  ) async* {
    if (state is AttemptLoginState) {
      var theState = state as AttemptLoginState;
      if (event is AttemptLoginEvent) {
        yield ValidateLoginState();
        yield theState;
      }
      if (event is LoginCredentialsValidatedEvent) {
        //we'll only receive this when there is a login being attempted so try to login
      }
    }
  }
}
