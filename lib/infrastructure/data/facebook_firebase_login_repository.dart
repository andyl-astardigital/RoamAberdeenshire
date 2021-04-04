import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/token_login_respository.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/authentication_errors.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/domain_error.dart';

class FacebookFirebaseLoginRepository extends TokenLoginRepository {
  final FirebaseAuth auth;

  FacebookFirebaseLoginRepository(this.auth);

  @override
  Future<AppUser> create(String token) async {
    try {
      final AuthCredential credential = FacebookAuthProvider.credential(token);
      final UserCredential userCreds =
          await auth.signInWithCredential(credential);

      return AppUser(userCreds.user.uid, userCreds.user.email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        return Future.error(EmailInUseError(token));
      }
      if (e.code == 'invalid-credential') {
        return Future.error(NoUserFoundError(null));
      }
      if (e.code == 'user-not-found') {
        return Future.error(NoUserFoundError(null));
      }
      if (e.code == 'invalid-credential') {
        return Future.error(NoUserFoundError(null));
      }
      return Future.error(GeneralError(e.toString()));
    } catch (e) {
      return Future.error(GeneralError(e.toString()));
    }
  }
}
