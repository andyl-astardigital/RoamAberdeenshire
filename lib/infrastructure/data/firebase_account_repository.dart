import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/account_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAccountRepository extends AccountRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<List<AppUser>> retrieveBy(Map<String, dynamic> params) {
    // TODO: implement retrieveBy
    throw UnimplementedError();
  }
}
