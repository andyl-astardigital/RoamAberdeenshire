import 'package:regexed_validator/regexed_validator.dart';

abstract class ValidEmailUseCase {
  bool validate(String email);
}

class ValidEmailUseCaseImpl implements ValidEmailUseCase {
  bool validate(String email) {
    return validator.email(email);
  }
}
