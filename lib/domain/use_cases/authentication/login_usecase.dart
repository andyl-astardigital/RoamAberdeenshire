import 'package:roam_aberdeenshire/domain/entities/user.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/user_repository.dart';
import 'package:roam_aberdeenshire/domain/shared/domain_error.dart';

class LoginUseCaseMessages {
  static final problem = "There was a problem during login.";
  static final noAccount = "No account match the given details.";
}

class NoUserFoundError extends DomainError {
  NoUserFoundError(String message, List<String> value) : super(message, value);
}

abstract class LoginUseCase {
  Future<User> login(String email, String password);
}

///Performs the logic to log a user in with the given details
///
///Future will resolve to the User object for the given details on success
///Future will error with NoUserFoundError if the details do not match
///Future will error with DomainError on error
class LoginUseCaseImpl implements LoginUseCase {
  UserRepository userRepo;

  LoginUseCaseImpl(this.userRepo);

  Future<User> login(String email, String password) async {
    return Future<User>.value(await userRepo
        .retrieveBy(({"email": email, "password": password}))
        .then((value) {
      if (value != null && value.isNotEmpty) {
        return value.first;
      }
      return Future<User>.error(
          NoUserFoundError(LoginUseCaseMessages.noAccount, [email, password]));
    }, onError: (error) {
      return Future<User>.error(
          DomainError(LoginUseCaseMessages.problem, [email, password]));
    }));
  }
}
