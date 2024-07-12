import 'dart:convert';

import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:pru_project_web/utils/resource.dart';
import 'package:retrofit/retrofit.dart';

import '../models/report_model.dart';
import '../models/user_model.dart';
import '../constants/constants.dart';

part 'generator.g.dart';

@RestApi(baseUrl: ApiConstants.BASE_URL)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  static RestClient create() {
    final dio = Dio();
    RestClient.debugHttpInterceptors(dio); // Burada çağrılıyor
    return RestClient(dio);
  }

  @POST('/getallreports.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<List<ReportModel>>> getAllReports();

  @POST('/pru/register.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<UserModel>> signup(@Body() Map<String, dynamic> user);

  @POST('/login.php')
  @Headers(
      <String, dynamic>{"Content-Type": "application/json", "charset": "utf-8", "Access-Control-Allow-Origin": "*"})
  Future<Resource<UserModel>> login(@Body() Map<String, dynamic> user);

  @POST('/pru/changepassword.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<bool>> changePassword(@Body() Map<String, dynamic> newPassword);

  @POST('/pru/sendotp.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<bool>> sendOtp(@Body() Map<String, dynamic> emailInfo);

  @POST('/pru/validateotp.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<bool>> validateOtp(@Body() Map<String, dynamic> emailInfo);

  @POST('/pru/deleteaccount.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<bool>> deleteAccount(@Body() Map<String, dynamic> userEmail);

  static void debugHttpInterceptors(Dio dio) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('onRequest');
        debugPrint("--> ${options.method} ${options.uri}");
        debugPrint("Headers: ${options.headers}");
        debugPrint("Data: ${options.data}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('onResponse');
        debugPrint("<-- ${response.statusCode} ${response.requestOptions.uri}");
        debugPrint("Response: ${response.data}");
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        debugPrint('onError');
        debugPrint("<-- Error ${e.response?.statusCode} ${e.response?.requestOptions.uri}");
        debugPrint("Message: ${e.message}");
        return handler.next(e);
      },
    ));
  }
}
