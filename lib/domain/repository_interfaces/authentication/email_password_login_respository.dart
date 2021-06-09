import 'package:roam_aberdeenshire/domain/entities/user_credentials.dart';
import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/generic_repository.dart';

abstract class EmailPasswordLoginRepository
    implements CreateRepository<UserCredentials, AppUser> {}
