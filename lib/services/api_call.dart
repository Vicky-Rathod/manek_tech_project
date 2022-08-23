import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:manek_tech_project/utils/const.dart';

class ApiRequest {
  Dio dio = Dio();
  Options opt = Options(headers: {
    "authorization": "Bearer ${AppConstant.token}",
  }, contentType: "application/x-www-form-urlencoded");

  String url;
  ApiRequest(
    this.url,
  );
  PostRequest() async {
    try {
      var response = await dio.post(
        url,
        options: opt,
      );
      if (response.statusCode == 200) {
        final body = json.decode(response.data);
        Map<String, dynamic> res = body;
        return res;
      }
    } catch (err) {
      return err;
    }
  }
}
