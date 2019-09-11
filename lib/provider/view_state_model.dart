import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fun_android/provider/view_state.dart';

class ViewStateModel with ChangeNotifier {
  ///防止页面销毁后，异步任务才完成，导致报错
  bool _disposed = false;

  ///当前页面状态，默认微idle，可在ViewModel的构造方法中指定
  ViewState _viewState;

  ViewStateModel({ViewState viewState}) : _viewState = viewState ?? ViewState.idle;

  ViewState get viewState => _viewState;

  set viewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  ///出错时的message
  String _errorMessage;

  String get errorMessage => _errorMessage;

  bool get busy => viewState == ViewState.busy;

  bool get idle => viewState == ViewState.idle;

  bool get empty => viewState == ViewState.empty;

  bool get error => viewState == ViewState.error;

  bool get unAuthorized => viewState == ViewState.unAuthorized;

  void setBusy(bool value) {
    _errorMessage = null;
    viewState = value ? ViewState.busy : ViewState.idle;
  }

  void setEmpty() {
    _errorMessage = null;
    viewState = ViewState.empty;
  }

  void setError(String errorMessage) {
    _errorMessage = errorMessage;
    viewState = ViewState.error;
  }

  void setUnAuthorized() {
    _errorMessage = null;
    viewState = ViewState.unAuthorized;
  }

  @override
  String toString() {
    return 'BaseModel{_viewState: $_viewState, errorMessage: $_errorMessage}';
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  ///统一处理子类的异常情况
  ///[e]有可能时Error，也有可能时Exception，所以需要判断处理
  ///[s]为堆栈信息
  void handleCatch(e, s) {
    if (e is DioError && e.error is UnAuthorizedException) {
      setUnAuthorized();
    } else {
      debugPrint('error---->\n' + e.toString());
      debugPrint('stack---->\n' + s.toString());
      setError(e is Error ? e.toString() : e.message);
    }
  }
}
