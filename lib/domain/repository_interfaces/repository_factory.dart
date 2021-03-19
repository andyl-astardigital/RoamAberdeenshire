import 'package:roam_aberdeenshire/domain/repository_interfaces/generic_repository.dart';

abstract class RepositoryFactory{
  GenericRepository getRepository<RepositoryType>();
}