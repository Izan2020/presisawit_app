abstract class DataState<T> {
  final T? data;
  final String? error;
  const DataState({this.data, this.error = 'Unknown Error Occured'});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataError<T> extends DataState<T> {
  const DataError(String? error) : super(error: error);
}
