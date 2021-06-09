import 'package:bloc/bloc.dart';
import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/authentication_errors.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/domain_error.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/login_email_password_usecase.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/login/login_exports.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/shared/ui_constants.dart';

abstract class LoginBloc extends Bloc<ILoginEvent, ILoginState> {
  LoginBloc(ILoginState state) : super(state);
}

class LoginBlocImpl extends LoginBloc {
  final LoginEmailPasswordUseCase loginuseCase;

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
              .login(UserCredentials(event.email, password: event.password));
          yield LoginSuccessfulState(user);
        } on EmailInUsedByOtherProvidersError catch (error) {
          yield LoginErrorState(error.message + error.providers.toString());
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
