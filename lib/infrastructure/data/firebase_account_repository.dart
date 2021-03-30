import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/account_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/domain_error.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/validation_errors.dart';

class FirebaseAccountRepository extends AccountRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<List<AppUser>> retrieveBy(Map<String, dynamic> params) async {
    var email = params["email"];
    try {
      var result = await auth.fetchSignInMethodsForEmail(email);

      if (result.isNotEmpty) return [AppUser("", email)];
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return Future.error(InvalidEmailError(email));
      }
      return Future.error(GeneralError(e.toString()));
    } catch (e) {
      return Future.error(GeneralError(e));
    }
    return Future.value(null);
  }
}
