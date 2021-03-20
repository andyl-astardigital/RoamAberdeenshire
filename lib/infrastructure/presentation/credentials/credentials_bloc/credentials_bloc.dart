import 'package:bloc/bloc.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/login_usecase.dart';
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

      if (event is EmailChangedEvent) {
        yield theState.copyWith(email: event.email);
        if (theState.validateOnEntry) {}
      }

      if (event is PasswordChangedEvent) {
        yield theState.copyWith(password: event.password);
        if (theState.validateOnEntry) {}
      }

      if (event is ToggleValidateOnEntryEvent) {
        yield theState.copyWith(validateOnEntry: !theState.validateOnEntry);
      }

      if (event is ValidateLoginEvent) {
        //being asked to validate only comes in from a login bloc so we only validate the email address
        var emailValid = vaildEmailUseCase.validate(theState.email);
        yield theState.copyWith(emailValid: emailValid);
        if (emailValid) {}
      }
    }
  }
}
