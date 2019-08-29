import 'dart:io';

import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  //app全部配置
  static SharedPreferences sharedPreference;

  //临时目录
  static Directory tempDirectory;

  //初始化必备操作
  static LocalStorage localStorage;

  ///必备数据的初始化操作
  ///
  /// 由于是同步操作会导致阻塞，所以应尽量减少存储容量
  static init() async {
    tempDirectory = await getTemporaryDirectory();
    sharedPreference = await SharedPreferences.getInstance();
    localStorage = LocalStorage('LocalStorage');
    await localStorage.ready;
  }
}
