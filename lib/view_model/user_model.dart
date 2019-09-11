import 'package:fun_android/config/storage_manager.dart';
import 'package:fun_android/model/user.dart';
import 'package:fun_android/provider/view_state_model.dart';

class UserModel extends ViewStateModel {
  static const String kUser = 'kUser';

  User _user;

  User get user => _user;

  bool get hasUser => _user != null;

  UserModel() {
    var userMap = StorageManager.localStorage.getItem(kUser);
    _user = userMap != null ? User.fromMap(userMap) : null;
  }

  saveUser(User user) {
    _user = user;
    notifyListeners();
    StorageManager.localStorage.setItem(kUser, _user);
  }

  ///清除持久化的用户数据
  clearUser() {
    _user = null;
    notifyListeners();
    StorageManager.localStorage.deleteItem(kUser);
  }
}
