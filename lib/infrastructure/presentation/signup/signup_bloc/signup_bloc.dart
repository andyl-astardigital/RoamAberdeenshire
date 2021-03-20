import 'package:bloc/bloc.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/signup_usecase.dart';

import '../signup_exports.dart';

abstract class SignupBloc extends Bloc<ISignupEvent, ISignupState> {
  SignupBloc(ISignupState state) : super(state);
}

class SignupBlocImpl extends SignupBloc {
  final SignupUseCase signupUseCase;

  SignupBlocImpl(this.signupUseCase) : super(SignupState());

  @override
  Stream<ISignupState> mapEventToState(
    ISignupEvent event,
  ) async* {
    if (state is AttemptSignupState) {
      var theState = state as AttemptSignupState;
      if (event is AttemptSignupEvent) {
        yield ValidateSignupState();
        yield theState;
      }
      if (event is SignupCredentialsValidatedEvent) {
        //we'll only receive this when there is a login being attempted so try to login
      }
    }
  }
}
