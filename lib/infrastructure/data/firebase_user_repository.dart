import 'package:roam_aberdeenshire/domain/entities/user.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/user_repository.dart';

class FirebaseUserRepository extends UserRepository{
  @override
  Future<User> create(User obj) {
      // TODO: implement create
      throw UnimplementedError();
    }
  
    @override
    Future<void> delete(User obj) {
      // TODO: implement delete
      throw UnimplementedError();
    }
  
    @override
    Future<List<User>> retrieveBy(Map<String, dynamic> params) {
      // TODO: implement retrieveBy
      throw UnimplementedError();
    }
  
    @override
    Future<User> retrieveById(String id) {
      // TODO: implement retrieveById
      throw UnimplementedError();
    }
  
    @override
    Future<void> update(User obj) {
    // TODO: implement update
    throw UnimplementedError();
  }
  
}