import 'package:uuid/uuid.dart';
import 'package:roam_aberdeenshire/domain/shared/base_entity.dart';

class AccountRecovery extends BaseEntity {
  String email;

  AccountRecovery(this.email) : super(Uuid());
}
