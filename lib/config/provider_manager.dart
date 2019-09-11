import 'package:fun_android/view_model/local_model.dart';
import 'package:fun_android/view_model/theme_model.dart';
import 'package:fun_android/view_model/user_model.dart';
import 'package:provider/provider.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

///独立的model
List<SingleChildCloneableWidget> independentServices = [
  ChangeNotifierProvider<ThemeModel>.value(value: ThemeModel()),
  ChangeNotifierProvider<LocaleModel>.value(value: LocaleModel()),
  ChangeNotifierProvider<UserModel>.value(value: UserModel()),
];

///需要依赖的model
List<SingleChildCloneableWidget> dependentServices = [];

List<SingleChildCloneableWidget> uiConsumableProviders = [];
