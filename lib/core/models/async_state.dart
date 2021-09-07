abstract class AsyncState<T>{
  final T data;
  const AsyncState(this.data);
}

class Initial<T> extends AsyncState<T>{
  const Initial(T data) : super(data);
}

class Loading<T> extends AsyncState<T>{
  const Loading(T data) : super(data);
}

class Success<T> extends AsyncState<T>{
  const Success(T data) : super(data);
}

class Error<T> extends AsyncState<T>{
  final String error;
  const Error(this.error, T data) : super(data);
}