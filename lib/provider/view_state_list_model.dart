import 'package:dio/dio.dart';
import 'package:fun_android/provider/view_state.dart';
import 'package:fun_android/provider/view_state_model.dart';

abstract class ViewStateListModel<T> extends ViewStateModel {
  List<T> list = [];

  ///第一次进入页面loading
  initData() {
    setBusy(true);
  }

  refresh({bool init = false}) async {
    try{
    List<T> data = await loadData();
    if (data.isEmpty) {
      setEmpty();
    } else {
      list = data;
      if (init) {
        ///改变页面状态为非加载中
        setBusy(false);
      } else {
        notifyListeners();
      }
    }}catch(e,s) {
      if(e is DioError &&e.error is UnAuthorizedException) {
        setUnAuthorized();
        return;
      }
      handleCatch(e,s);
    }
  }

  Future<List<T>> loadData();
}
