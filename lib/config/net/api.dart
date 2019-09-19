import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fun_android/utils/platform_utils.dart';

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  //isolated的说明 http://www.ptbird.cn/flutter-isolate-compute-http-data.html
  return compute(_parseAndDecode, text);
}

abstract class BaseHttp extends Dio {
  BaseHttp() {
    ///初始化，加入app通用处理
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    interceptors.add(HeaderInterceptor());
    init();
  }

  void init();
}

///添加常用Header
class HeaderInterceptor extends Interceptor {
  @override
  FutureOr<dynamic> onRequest(RequestOptions options) async {
    options.connectTimeout = 1000 * 45;
    options.receiveTimeout = 1000 * 45;

    var appVersion = await PlatformUtils.getAppVersion();

    var version = Map()
      ..addAll({
        'appVersion': appVersion,
      });
    options.headers['version'] = version;
    options.headers['platform'] = Platform.operatingSystem;
    return options;
  }
}
