// ignore_for_file: avoid_field_initializers_in_const_classes
// ignore_for_file: prefer_initializing_formals

class RequestResult<T> {
  const RequestResult.success(T data)
      : _result = data,
        _error = null;

  RequestResult.error(Object? error, [StackTrace? stackTrace])
      : _result = null,
        _error = RequestError(error, stackTrace);

  final RequestError? _error;
  final T? _result;

  bool get isSuccess => _error == null;
  bool get isError => _error != null;

  T get value => _result as T;
  RequestError get error {
    if (_error == null) {
      throw Exception('RequestResult is not an error');
    }

    // ignore: cast_nullable_to_non_nullable
    return _error as RequestError;
  }
}

class RequestError {
  const RequestError(this.exception, [this.stackTrace]);

  final Object? exception;
  final StackTrace? stackTrace;
}
