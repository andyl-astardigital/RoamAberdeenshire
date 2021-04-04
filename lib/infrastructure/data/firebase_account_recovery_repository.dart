import 'package:roam_aberdeenshire/domain/entities/account_recovery.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/authentication/account_recovery_repository.dart';

class FirebaseAccountRecoveryRepository extends AccountRecoveryRepository {
  final FirebaseAuth auth;

  FirebaseAccountRecoveryRepository(this.auth);

  @override
  Future<bool> create(AccountRecovery obj) {
    // TODO: implement create
    throw UnimplementedError();
  }
}
