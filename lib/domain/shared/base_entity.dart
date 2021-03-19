import 'package:uuid/uuid.dart';
abstract class BaseEntity {
  Uuid id;
  BaseEntity(this.id);
}