
import 'package:uuid/uuid.dart';
import 'package:roam_aberdeenshire/domain/shared/base_entity.dart';

class User extends BaseEntity{
  String name;
  String email;
  String password;
  User(Uuid id, this.email, this.password):super(id);
}