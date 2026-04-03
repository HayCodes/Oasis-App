import 'package:dio/dio.dart';
import 'package:oasis/common/common.dart';

class AbstractApiResponse {
  AbstractApiResponse({required this.status, this.message, this.data});

  AbstractApiResponse.fromJson(DynamicMap json) {
    status = !json.containsKey('status') || json['status'] == true;
    message = json['message'] ?? AppTexts.GENERIC_ERROR;
    data = json.containsKey('data') ? json['data'] : json;
  }

  bool status = false;
  String? message;
  dynamic data;
}

AbstractApiResponse handleResponse(Response res) {
  return AbstractApiResponse.fromJson(res.data);
}
