import 'package:roam_aberdeenshire/domain/repository_interfaces/user_repository.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_email_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_password_usecase.dart';
import 'package:uuid/uuid.dart';
import 'package:roam_aberdeenshire/domain/entities/user.dart';
import 'package:roam_aberdeenshire/domain/shared/domain_error.dart';

class SignupUseCaseMessages {
  static final problem = "There was a problem during signup.";
  static final alreadyInUse = "Email address already in use.";
}

class EmailInUseError extends DomainError {
  EmailInUseError(String message, String email) : super(message, email);
}

abstract class SignupUseCase {
  Future<User> signup(String email, String password);
}

///Performs the logic to sign up a user with the given details
///
///Future will resolve to the User object for the given details on success
///Future will error with DomainError if the email is invalid
///Future will error with DomainError if the password is invalid
///Future will error with EmailInUseError if the email is already in use
///Future will error with DomainError on error
class SignupUseCaseImpl implements SignupUseCase {
  UserRepository userRepo;
  ValidEmailUseCase validEmailUseCase;
  ValidPasswordUseCase validPasswordUseCase;

  SignupUseCaseImpl(
      this.userRepo, this.validEmailUseCase, this.validPasswordUseCase);

  Future<User> signup(String email, String password) async {
    if (!validEmailUseCase.validate(email)) {
      return Future.error(DomainError("Email is invalid ", email));
    }
    if (!validPasswordUseCase.validate(password)) {
      return Future<User>.error(
          DomainError("Password isn't strong enough", password));
    }
    return Future.value(await userRepo
        .retrieveBy(({"email": email, "password": password}))
        .then((value) async {
      if (value != null && value.isNotEmpty) {
        return Future<User>.error(
            EmailInUseError(SignupUseCaseMessages.alreadyInUse, email));
      }
      User newUser = User(Uuid(), email, password);
      await userRepo.create(newUser);
      return newUser;
    }, onError: (error) {
      return Future<User>.error(
          DomainError(SignupUseCaseMessages.problem, [email, password]));
    }));
  }
}
