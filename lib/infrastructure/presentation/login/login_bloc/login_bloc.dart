import 'package:bloc/bloc.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/login_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_email_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_password_usecase.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/login/login.dart';

abstract class LoginBloc extends Bloc<ILoginEvent, ILoginState>{
  LoginBloc(ILoginState state): super(state);
}

class LoginBlocImpl extends LoginBloc {
  LoginUseCase loginuseCase;
  ValidEmailUseCase vaildEmailUseCase;
  ValidPasswordUseCase validPasswordUseCase;
  LoginBlocImpl(
      this.loginuseCase, this.vaildEmailUseCase, this.validPasswordUseCase)
      : super(LoginState.init());

  @override
  Stream<ILoginState> mapEventToState(
    ILoginEvent event,
  ) async* {
    if (state is LoginState) {
      //after logging in this state is LoggingInState which is wrong
      var theState = state as LoginState;
      if (event is EmailChangedEvent) {
        yield theState.copyWith(email: event.email);
      }

      if (event is PasswordVisibilityEvent) {
        yield theState.copyWith(passwordVisible: !theState.passwordVisible);
      }

      if (event is LoggingInEvent) {
        var emailValid = vaildEmailUseCase.validate(theState.email);

        if (emailValid) {
          yield LoggingInState(theState.email);
          yield theState;
        }
        yield theState.copyWith(
          emailInvalid: !emailValid,
        );
      }

      if (event is AuthErrorEvent) {
        yield ErrorState(event.error);
        yield theState;
      }
    }
  }
}
