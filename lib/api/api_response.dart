class ApiResponse<DATA> {
  final DATA data;
  final ApiError apiError;

  ApiResponse({this.data, this.apiError});
}

class ApiError {
  final int code;
  final String error;

  ApiError(this.code, this.error);
}