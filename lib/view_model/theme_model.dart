import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_android/config/storage_manager.dart';
import 'package:fun_android/generated/i18n.dart';
import 'package:fun_android/ui/helper/theme_helper.dart';

class ThemeModel with ChangeNotifier {
  static const kThemeColorIndex = 'kThemeColorIndex';
  static const kThemeBrightnessIndex = 'kThemeBrightnessIndex';
  static const kFontIndex = 'kFontIndex';

  static const fontValueList = ['system', 'kuaile'];

  ThemeData _themeData;

  ///明暗模式
  Brightness _brightness;

  ///当前主题颜色
  MaterialColor _themeColor;

  ///当前字体索引
  int _fontIndex;

  ThemeModel() {
    ///明暗模式，0为dark，1为light
    _brightness =
        Brightness.values[StorageManager.sharedPreference.getInt(kThemeBrightnessIndex) ?? 0];

    ///获取主题色
    _themeColor = Colors.primaries[StorageManager.sharedPreference.getInt(kThemeColorIndex) ?? 0];

    ///获取字体
    _fontIndex = StorageManager.sharedPreference.getInt(kFontIndex) ?? 0;

    _generateThemeData();
  }

  ThemeData get themeData => _themeData;

  ThemeData get darkTheme => _themeData.copyWith(brightness: Brightness.dark);

  int get fontIndex => _fontIndex;

  ///切换指定色彩
  ///没有传[brightness]就不改变brightness，color同理
  void switchTheme({Brightness brightness, MaterialColor color}) {
    _brightness = brightness ?? _brightness;
    _themeColor = color ?? _themeColor;
    _generateThemeData();
    notifyListeners();
    saveTheme2Storage(_brightness, _themeColor);
  }

  ///随机一个主题色彩
  ///可以指定明暗模式，不指定则保持不变
  void switchRandomTheme({Brightness brightness}) {
    brightness ??= (Random().nextBool() ? Brightness.dark : Brightness.light);
    var colorIndex = Random().nextInt(Colors.primaries.length - 1);
    switchTheme(brightness: brightness, color: Colors.primaries[colorIndex]);
  }

  ///切换字体
  void switchFont(int index) {
    _fontIndex = index;
    switchTheme();
    saveFontIndex(_fontIndex);
  }

  ///根据主题 明暗和颜色生成对应的主题
  void _generateThemeData() {
    var isDark = Brightness.dark == _brightness;
    var themeColor = _themeColor;
    var accentColor = isDark ? themeColor[700] : _themeColor;
    var themeData = ThemeData(
        brightness: _brightness,

        ///主题颜色属于亮色系还是属于暗色系（eg:dark时，AppBarTitle文字及状态栏文字的颜色为白色，反之为黑色）
        primaryColorBrightness: Brightness.dark,
        accentColorBrightness: Brightness.dark,
        primarySwatch: themeColor,
        accentColor: accentColor,
        fontFamily: fontValueList[_fontIndex]);

    themeData = themeData.copyWith(
      brightness: _brightness,
      accentColor: accentColor,
      appBarTheme: themeData.appBarTheme.copyWith(elevation: 0),
      splashColor: themeColor.withAlpha(50), // 点击按钮时的渐变背景色，当你不设置高亮背景时才会看的更清楚
      hintColor: themeData.hintColor.withAlpha(90),
      errorColor: accentColor,
      textSelectionColor: accentColor.withAlpha(60),
      textSelectionHandleColor: accentColor.withAlpha(60),
      toggleableActiveColor: accentColor,
      chipTheme: themeData.chipTheme.copyWith(
        pressElevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 10),
        labelStyle: themeData.textTheme.caption,
        backgroundColor: themeData.chipTheme.backgroundColor.withOpacity(0.1),
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: themeColor,
          brightness: _brightness,
          textTheme: CupertinoTextThemeData(brightness: Brightness.light)),
      inputDecorationTheme: ThemeHelper.inputDecorationTheme(themeData),
    );

    _themeData = themeData;
  }

  ///数据持久化到SharedPreference
  void saveTheme2Storage(Brightness brightness, MaterialColor themeColor) async {
    var index = Colors.primaries.indexOf(themeColor);
    await Future.wait([
      StorageManager.sharedPreference.setInt(kThemeColorIndex, index),
      StorageManager.sharedPreference.setInt(kThemeBrightnessIndex, brightness.index)
    ]);
  }

  ///根据索引获取字体名称，这里牵涉到国际化
  static String fontName(int index, BuildContext context) {
    switch (index) {
      case 0:
        return S.of(context).autoBySystem;
      case 1:
        return S.of(context).fontKuaiLe;
      default:
        return "";
    }
  }

  ///字体选择持久化
  static void saveFontIndex(int index) async {
    await StorageManager.sharedPreference.setInt(kFontIndex, index);
  }
}
