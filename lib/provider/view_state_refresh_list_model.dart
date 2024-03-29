import 'package:flutter/material.dart';
import 'package:fun_android/provider/view_state_list_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class ViewStateRefreshListModel<T> extends ViewStateListModel {
  ///分页第一页页码
  static const int pageNumFirst = 0;

  ///分页条目数量
  static const int pageSize = 20;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  ///当前页码
  int _currentPageNum = pageNumFirst;

  ///下拉刷新
  @override
  Future<List<T>> refresh({bool init = false}) async {
    try {
      //重置当前页码
      _currentPageNum = pageNumFirst;
      List<T> data = await loadData();
      if (data.isEmpty) {
        setEmpty();
      } else {
        list.clear();
        list.addAll(data);
        refreshController.refreshCompleted();
        if (data.length < pageSize) {
          refreshController.loadNoData();
        } else {
          ///防止上拉加载更多失败，需要重置状态
          refreshController.loadComplete();
        }
      }

      if (init) {
        //改变页面状态为非加载中
        setBusy(false);
      } else {
        notifyListeners();
      }

      return data;
    } catch (e, s) {
      handleCatch(e, s);
      return null;
    }
  }

  ///上拉加载更多
  Future<List<T>> loadMore() async {
    try {
      var data = await loadData(pageNum: ++_currentPageNum);
      if (data.isEmpty) {
        _currentPageNum--;
        refreshController.loadNoData();
      } else {
        list.addAll(data);
        if (data.length < pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        notifyListeners();
      }
      return data;
    } catch (e, s) {
      _currentPageNum--;
      refreshController.loadFailed();
      debugPrint('error--->\n' + e.toString());
      debugPrint('statck--->\n' + s.toString());
      return null;
    }
  }

  Future<List<T>> loadData({int pageNum});
}
