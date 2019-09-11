import 'package:flutter/material.dart';
import 'package:fun_android/config/storage_manager.dart';
import 'package:oktoast/oktoast.dart';

///项目源地址 https://github.com/phoenixsky/fun_android_flutter
void main() async {
  //初始化操作，单例，负责创建WidgetsFlutterBinding对象
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  runApp(App());
}

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List list1 = [1, 2, 3];
    List list2 = [4, 5, 6];
    List list = [list1, list2];
    List list3 = [...list1, ...list2];

    print(list.toString());
    print(list3.toString());


    return OKToast(child: MaterialApp());
  }
}
