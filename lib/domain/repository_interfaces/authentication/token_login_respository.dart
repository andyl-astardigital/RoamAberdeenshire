import 'package:roam_aberdeenshire/domain/entities/app_user.dart';
import 'package:roam_aberdeenshire/domain/repository_interfaces/generic_repository.dart';

abstract class TokenLoginRepository
    implements CreateRepository<String, AppUser> {}
