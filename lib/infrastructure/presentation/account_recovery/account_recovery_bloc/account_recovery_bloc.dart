import 'package:bloc/bloc.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/authentication_errors.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/domain_error.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/account_recovery_usecase.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/shared/ui_constants.dart';

import '../account_recovery_exports.dart';

abstract class AccountRecoveryBloc
    extends Bloc<IAccountRecoveryEvent, IAccountRecoveryState> {
  AccountRecoveryBloc(IAccountRecoveryState state) : super(state);
}

class AccountRecoveryBlocImpl extends AccountRecoveryBloc {
  final AccountRecoveryUseCase accountRecoveryUseCase;

  AccountRecoveryBlocImpl(this.accountRecoveryUseCase)
      : super(AccountRecoveryState());

  @override
  Stream<IAccountRecoveryState> mapEventToState(
    IAccountRecoveryEvent event,
  ) async* {
    if (state is AccountRecoveryState) {
      var theState = state as AccountRecoveryState;
      if (event is AccountRecoveryValidateEvent) {
        yield AccountRecoveryValidateState();
        yield theState;
      }

      if (event is AccountRecoveryCredentialsValidatedEvent) {
        try {
          await accountRecoveryUseCase.recoverPassword(event.email);
          yield AccountRecoverySuccessfulState();
        } on DomainError catch (error) {
          yield AccountRecoveryErrorState(error.message);
        } catch (error) {
          yield AccountRecoveryErrorState(UIConstants.genericError);
        } finally {
          yield theState;
        }
      }
    }
  }
}
