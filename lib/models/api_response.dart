class ApiResponse<T>
{
  T? body;
  int? statusCode;
  String? reasonPhrase;
  bool? error;
  ApiResponse({this.body,this.statusCode,this.error = false,this.reasonPhrase});
}