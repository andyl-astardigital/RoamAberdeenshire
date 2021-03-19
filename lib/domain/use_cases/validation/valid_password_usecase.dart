import 'package:regexed_validator/regexed_validator.dart';

abstract class ValidPasswordUseCase {
  bool validate(String password);
}

class ValidPasswordUseCaseImpl implements ValidPasswordUseCase {
  bool validate(String password) {
    return validator.password(password);
  }
}
