import 'dart:async';

import 'package:roam_aberdeenshire/domain/shared/base_entity.dart';

abstract class CreateRepository<ObjectType extends BaseEntity> {
  /// Creates an object of the given type in the persistence method
  ///
  /// Future will resolve to void if successful
  /// Future will error with a DomainError if a problem occurs
  Future<void> create(ObjectType obj);
}

abstract class RetrieveByRepository<ObjectType extends BaseEntity> {
  /// Retrieve the objects that match the given parameters from the persistence method
  ///
  /// Future will resolve to List of objects if successful
  /// Future will resolve to null if not found
  /// Future will error with a DomainError if a problem occurs
  Future<List<ObjectType>> retrieveBy(Map<String, dynamic> params);
}

abstract class RetrieveByIdRepository<ObjectType extends BaseEntity> {
  /// Retrieve the object with the given Id from the persistence method
  ///
  /// Future will resolve to the object if successful
  /// Future will resolve to null if not found
  /// Future will error with a DomainError if a problem occurs
  Future<ObjectType> retrieveById(String id);
}

abstract class UpdateRepository<ObjectType extends BaseEntity> {
  /// Update an object in the persistence method
  ///
  /// Future will resolve to void on success
  /// Future will error with a DomainError if a problem occurs
  Future<void> update(ObjectType obj);
}

abstract class DeleteRepository<ObjectType extends BaseEntity> {
  /// Delete an object in the persistence method
  ///
  /// Future will resolve to void on success
  /// Future will error with a DomainError if a problem occurs
  Future<void> delete(ObjectType obj);
}
