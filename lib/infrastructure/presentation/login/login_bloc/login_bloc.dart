import 'package:bloc/bloc.dart';
import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/shared/domain_error.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/login_usecase.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/login/login_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/shared/ui_constants.dart';

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
    if (state is LoginState) {
      var theState = state as LoginState;
      if (event is LoginValidateEvent) {
        yield LoginValidateState();
        yield theState;
      }

      if (event is LoginCredentialsValidatedEvent) {
        try {
          var user = await loginuseCase
              .login(UserCredentials(event.email, event.password));
          yield LoginSuccessfulState(user);
        } on NoUserFoundError catch (error) {
          yield LoginErrorState(error.message);
        } on DomainError catch (error) {
          yield LoginErrorState(error.message);
        } catch (error) {
          yield LoginErrorState(UIConstants.genericError);
        } finally {
          yield theState;
        }
      }
    }
  }
}
