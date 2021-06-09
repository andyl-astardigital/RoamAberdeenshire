import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/email_password_login_respository.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/authentication_errors.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/domain_error.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/validation_errors.dart';

class FirebaseEmailPasswordLoginRepository
    extends EmailPasswordLoginRepository {
  final FirebaseAuth auth;

  FirebaseEmailPasswordLoginRepository(this.auth);

  @override
  Future<AppUser> create(UserCredentials obj) async {
    try {
      var result = await auth.signInWithEmailAndPassword(
          email: obj.email, password: obj.password);

      return AppUser(result.user.uid, result.user.email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return Future.error(InvalidEmailError(obj.email));
      }
      if (e.code == 'user-not-found') {
        return Future.error(NoUserFoundError(obj));
      }
      return Future.error(GeneralError(e.toString()));
    } catch (e) {
      return Future.error(GeneralError(e.toString()));
    }
  }
}
