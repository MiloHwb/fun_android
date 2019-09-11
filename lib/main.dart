import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fun_android/config/storage_manager.dart';
import 'package:fun_android/view_model/local_model.dart';
import 'package:fun_android/view_model/theme_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'config/provider_manager.dart';
import 'config/route_config.dart';
import 'generated/i18n.dart';

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
    return OKToast(
      child: MultiProvider(
        providers: providers,
        child:
            Consumer2<ThemeModel, LocaleModel>(builder: (context, themeModel, localeModel, child) {
          return RefreshConfiguration(
            hideFooterWhenNotFull: true, //列表数据不满一夜，不触发加载更多
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeModel.themeData,
              darkTheme: themeModel.darkTheme,
              locale: localeModel.locale,
              localizationsDelegates: const[
                S.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              onGenerateRoute: Router.generateRoute,
              initialRoute: RouteName.splash,
            ),
          );
        }),
      ),
    );
  }
}
