import 'dart:async';

abstract class CreateRepository<InputType, ReturnType> {
  /// Creates an object of the given type in the persistence method
  ///
  /// Future will resolve to ReturnType if successful
  /// Future will error with a DomainError if a problem occurs
  Future<ReturnType> create(InputType obj);
}

abstract class RetrieveByRepository<ReturnType> {
  /// Retrieve the objects that match the given parameters from the persistence method
  ///
  /// Future will resolve to List of ReturnType if successful
  /// Future will resolve to null if not found
  /// Future will error with a DomainError if a problem occurs
  Future<List<ReturnType>> retrieveBy(Map<String, dynamic> params);
}

abstract class RetrieveByIdRepository<ReturnType> {
  /// Retrieve the object with the given Id from the persistence method
  ///
  /// Future will resolve to ReturnType if successful
  /// Future will resolve to null if not found
  /// Future will error with a DomainError if a problem occurs
  Future<ReturnType> retrieveById(String id);
}

abstract class UpdateRepository<InputType> {
  /// Update an object in the persistence method
  ///
  /// Future will resolve to Boolean on success
  /// Future will error with a DomainError if a problem occurs
  Future<bool> update(InputType obj);
}

abstract class DeleteRepository<InputType> {
  /// Delete an object in the persistence method
  ///
  /// Future will resolve to Boolean on success
  /// Future will error with a DomainError if a problem occurs
  Future<bool> delete(InputType obj);
}
