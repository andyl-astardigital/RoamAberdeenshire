import 'package:uuid/uuid.dart';
import 'package:roam_aberdeenshire/domain/shared/base_entity.dart';

class AppUser {
  String id;
  String name;
  String email;

  AppUser(this.id, this.email);
}
