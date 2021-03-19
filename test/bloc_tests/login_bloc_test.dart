import 'package:roam_aberdeenshire/domain/entities/user.dart';
import 'package:roam_aberdeenshire/domain/use_cases/authentication/login_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_email_usecase.dart';
import 'package:roam_aberdeenshire/domain/use_cases/validation/valid_password_usecase.dart';
import 'package:roam_aberdeenshire/infrastructure/presentation/login/login.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

String name = "foo";
String email = "foo@bar.com";
String password = "!23FooBar-ForMe";
Uuid id = Uuid();
User theUser = User(Uuid(), email, password);

class MockLoginUseCase extends LoginUseCase {
  @override
  Future<User> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }
}

void main() {
  test('LoginBloc ', () async {
    var loginBloc = LoginBlocImpl(MockLoginUseCase(), ValidEmailUseCaseImpl(),
        ValidPasswordUseCaseImpl());
  });
}
