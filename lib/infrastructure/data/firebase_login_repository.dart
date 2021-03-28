import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/login_respository.dart';

class FirebaseLoginRepository extends LoginRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<AppUser> create(UserCredentials obj) {
    // TODO: implement create
    throw UnimplementedError();
  }
}
