import 'package:uuid/uuid.dart';

abstract class BaseEntity {
  String id;
  BaseEntity(this.id);
}
