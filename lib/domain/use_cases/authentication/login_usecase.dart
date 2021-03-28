import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/login_respository.dart';
import 'package:roam_aberdeenshire/domain/shared/domain_error.dart';

class LoginUseCaseMessages {
  static final problem = "There was a problem during login.";
  static final noAccount = "No account match the given details.";
}

class NoUserFoundError extends DomainError {
  NoUserFoundError(String message, UserCredentials credentials)
      : super(message, credentials);
}

abstract class LoginUseCase {
  Future<AppUser> login(UserCredentials credentials);
}

///Performs the logic to log a user in with the given details
///
///Future will resolve to the User object for the given details on success
///Future will error with NoUserFoundError if the details do not match
///Future will error with DomainError on error
class LoginUseCaseImpl implements LoginUseCase {
  final LoginRepository loginRepo;

  LoginUseCaseImpl(this.loginRepo);

  Future<AppUser> login(UserCredentials credentials) async {
    return Future<AppUser>.value(await loginRepo
        .create((UserCredentials(credentials.email, credentials.password)))
        .then((value) {
      if (value != null) {
        return value;
      }
      return Future<AppUser>.error(
          NoUserFoundError(LoginUseCaseMessages.noAccount, credentials));
    }, onError: (error) {
      return Future<AppUser>.error(
          DomainError(LoginUseCaseMessages.problem, credentials));
    }));
  }
}
