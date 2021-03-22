import 'package:bloc/bloc.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_email_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_password_usecase.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/credentials/credentials_exports.dart';

abstract class CredentialsBloc
    extends Bloc<ICredentialsEvent, ICredentialsState> {
  CredentialsBloc(ICredentialsState state) : super(state);
}

class CredentialsBlocImpl extends CredentialsBloc {
  final ValidEmailUseCase vaildEmailUseCase;
  final ValidPasswordUseCase validPasswordUseCase;

  CredentialsBlocImpl(this.vaildEmailUseCase, this.validPasswordUseCase)
      : super(CredentialsState.init());

  @override
  Stream<ICredentialsState> mapEventToState(
    ICredentialsEvent event,
  ) async* {
    if (state is CredentialsState) {
      var theState = state as CredentialsState;

      if (event is CredentialsEmailChangedEvent) {
        if (theState.validateOnEntry) {
          yield theState.copyWith(
              email: event.email,
              emailValid: vaildEmailUseCase.validate(event.email));
        } else {
          yield theState.copyWith(email: event.email);
        }
      }

      if (event is CredentialsPasswordChangedEvent) {
        if (theState.validateOnEntry) {
          yield theState.copyWith(
              password: event.password,
              passwordValid: validPasswordUseCase.validate(event.password));
        } else {
          yield theState.copyWith(password: event.password);
        }
      }

      if (event is CredentialsToggleValidateOnEntryEvent) {
        yield theState.copyWith(validateOnEntry: !theState.validateOnEntry);
      }

      if (event is CredentialsTogglePasswordVisibilityEvent) {
        yield theState.copyWith(passwordVisible: !theState.passwordVisible);
      }

      if (event is CredentialsValidateLoginEvent) {
        //being asked to validate only comes in from a login bloc so we only validate the email address
        var emailValid = vaildEmailUseCase.validate(theState.email);

        if (emailValid)
          yield CredentialsValidLoginState(theState.email, theState.password);

        yield theState.copyWith(emailValid: emailValid);
      }

      if (event is CredentialsValidateSignupEvent) {
        //being asked to validate only comes in from a login bloc so we only validate the email address
        var emailValid = vaildEmailUseCase.validate(theState.email);
        var passwordValid = validPasswordUseCase.validate(theState.password);

        if (emailValid && passwordValid)
          yield CredentialsValidSignupState(theState.email, theState.password);

        yield theState.copyWith(
            emailValid: emailValid, passwordValid: passwordValid);
      }

      if (event is CredentialsResetValidationEvent) {
        yield CredentialsState.init();
      }
    }
  }
}
