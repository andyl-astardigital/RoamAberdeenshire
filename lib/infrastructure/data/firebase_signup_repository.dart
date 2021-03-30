import 'package:firebase_auth/firebase_auth.dart';
import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/signup_repository.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/authentication_errors.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/domain_error.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/validation_errors.dart';

class FirebaseSignupRepository extends SignupRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<AppUser> create(UserCredentials obj) async {
    try {
      UserCredential credentials = await auth.createUserWithEmailAndPassword(
          email: obj.email, password: obj.password);

      return AppUser(credentials.user.uid, credentials.user.email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.error(InvalidPasswordError(obj.password));
      }
      if (e.code == 'email-already-in-use') {
        return Future.error(EmailInUseError(obj));
      }
      return Future.error(GeneralError(e.toString()));
    } catch (e) {
      return Future.error(GeneralError(e.toString()));
    }
  }
}
