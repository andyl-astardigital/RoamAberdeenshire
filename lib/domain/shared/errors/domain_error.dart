abstract class DomainError<ResultType> {
  final String message;
  final ResultType value;

  DomainError(this.message, this.value);
}

class GeneralErrorMessages {
  static String generalError =
      "An error occured. Please contact our support team.";
}

class GeneralError<ResultType> extends DomainError {
  GeneralError(value) : super(GeneralErrorMessages.generalError, value);
}
