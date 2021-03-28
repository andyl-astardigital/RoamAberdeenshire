import 'package:firebase_auth/firebase_auth.dart';
import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/signup_repository.dart';

class FirebaseSignupRepository extends SignupRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<AppUser> create(UserCredentials obj) async {
    try {
      UserCredential credentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: obj.email, password: obj.password);

      return AppUser(credentials.user.uid, credentials.user.email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
