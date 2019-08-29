import 'package:flutter/material.dart';
import 'package:fun_android/config/storage_manager.dart';
import 'package:oktoast/oktoast.dart';

///项目源地址 https://github.com/phoenixsky/fun_android_flutter
void main()async{
  //初始化操作，单例，负责创建WidgetsFlutterBinding对象
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  runApp(App());

}

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
       return OKToast(child: MaterialApp());
  }
}

