class DomainError<ResultType> {
  final String message;
  final ResultType value;

  DomainError(this.message, this.value);
}

class InvalidInputError<InputType> extends DomainError<InputType> {
  InvalidInputError(String message, InputType value) : super(message, value);
}
