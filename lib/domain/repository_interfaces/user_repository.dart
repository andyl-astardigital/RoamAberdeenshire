import 'package:roam_aberdeenshire/domain/entities/user.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/generic_repository.dart';

abstract class UserRepository
    implements
        CreateRepository<User>,
        RetrieveByIdRepository<User>,
        RetrieveByRepository<User>,
        UpdateRepository<User>,
        DeleteRepository<User> {}
