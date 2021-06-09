import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/account_providers_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/domain_error.dart';
import 'package:roam_aberdeenshire/domain/shared/errors/validation_errors.dart';

class FirebaseAccountProvidersRepository extends AccountProvidersRepository {
  final FirebaseAuth auth;

  FirebaseAccountProvidersRepository(this.auth);

  @override
  Future<List<String>> retrieveBy(Map<String, dynamic> params) async {
    var email = params["email"];
    try {
      return auth.fetchSignInMethodsForEmail(email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return Future.error(InvalidEmailError(email));
      }
      return Future.error(GeneralError(e.toString()));
    } catch (e) {
      return Future.error(GeneralError(e));
    }
  }
}
