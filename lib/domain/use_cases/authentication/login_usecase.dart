import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/login_respository.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/authentication_errors.dart';

abstract class LoginUseCase {
  Future<AppUser> login(UserCredentials credentials);
}

///Performs the logic to log a user in with the given details
///
///Future will resolve to the User object for the given details on success
///Future will error with NoUserFoundError if the details do not match
///Future will error with GeneralError on error
class LoginUseCaseImpl implements LoginUseCase {
  final LoginRepository loginRepo;

  LoginUseCaseImpl(this.loginRepo);

  Future<AppUser> login(UserCredentials credentials) async {
    var user = await loginRepo.create(
        (UserCredentials(credentials.email, password: credentials.password)));

    if (user != null) {
      return Future<AppUser>.value(user);
    }
    return Future<AppUser>.error(NoUserFoundError(credentials));
  }
}
