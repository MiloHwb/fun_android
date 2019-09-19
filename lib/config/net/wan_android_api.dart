import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fun_android/config/net/api.dart';
import 'package:fun_android/config/storage_manager.dart';

final Http wanHttp = Http();

class Http extends BaseHttp {
  @override
  void init() {
    interceptors
      ..add(ApiInterceptor())
      ..add(CookieManager(PersistCookieJar(dir: StorageManager.tempDirectory.path)));//CookieManager
  }
}

class ApiInterceptor extends InterceptorsWrapper {
  static const String baseUrl = 'https://www.wanandroid.com/';

  @override
  onRequest(RequestOptions options) {
    options.baseUrl = baseUrl;
    debugPrint('---api-request--->url---> ${options.baseUrl}${options.path}' +
        ' queryParameters: ${options.queryParameters}');
    return options;
  }

  @override
  onResponse(Response response) {}

  @override
  onError(DioError err) {}
}
