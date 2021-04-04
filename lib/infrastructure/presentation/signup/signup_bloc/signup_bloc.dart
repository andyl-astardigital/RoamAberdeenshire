import 'package:bloc/bloc.dart';
import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/domain_error.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/email_signup_usecase.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/shared/ui_constants.dart';

import '../signup_exports.dart';

abstract class SignupBloc extends Bloc<ISignupEvent, ISignupState> {
  SignupBloc(ISignupState state) : super(state);
}

class SignupBlocImpl extends SignupBloc {
  final EmailSignupUseCase signupUseCase;

  SignupBlocImpl(this.signupUseCase) : super(SignupState());

  @override
  Stream<ISignupState> mapEventToState(
    ISignupEvent event,
  ) async* {
    if (state is SignupState) {
      var theState = state as SignupState;
      if (event is SignupValidateEvent) {
        yield SignupValidateState();
        yield theState;
      }

      if (event is SignupCredentialsValidatedEvent) {
        try {
          var user = await signupUseCase
              .signup(UserCredentials(event.email, password: event.password));
          yield SignupSuccessfulState(user);
        } on DomainError catch (error) {
          yield SignupErrorState(error.message);
        } catch (error) {
          yield SignupErrorState(UIConstants.genericError);
        } finally {
          yield theState;
        }
      }
    }
  }
}
