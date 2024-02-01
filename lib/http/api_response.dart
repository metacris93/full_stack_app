class ApiResponse<T> {
  final bool succeeded;
  final String message;
  final List<String> errors;
  final T? data;

  ApiResponse(
      {required this.succeeded,
      required this.message,
      required this.errors,
      this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      succeeded: json['succeeded'],
      message: json['message'],
      errors: List<String>.from(json['errors']),
      data: json['data'] as T?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'succeeded': succeeded,
      'message': message,
      'errors': errors,
      'data': data,
    };
  }
}
