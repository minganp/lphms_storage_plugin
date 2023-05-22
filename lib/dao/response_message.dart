class ResponseMessage{
  final String status;
  final String message;
  late final dynamic data;

  ResponseMessage({required this.status,required this.message,required this.data});

  bool get isSuccess => status == "success";
  Map<String,dynamic> get msgBody => {
    "status": status,
    "message": message,
    "data": data
  };
}