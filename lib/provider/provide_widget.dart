import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///Provider 封装类
///方便数据初始化

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final ValueWidgetBuilder<T> builder;
  final T model;
  final Widget child;
  final Function(T) onModelReady;

  ProviderWidget({
    Key key,
    @required this.builder,
    @required this.model,
    this.child,
    this.onModelReady,
  }) : super(key: key);

  @override
  _ProviderWidgetState<T> createState() {
    return _ProviderWidgetState<T>();
  }
}

class _ProviderWidgetState<T extends ChangeNotifier> extends State<ProviderWidget<T>> {
  T model;

  @override
  void initState() {
    model = widget.model;
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      builder: (context) => model,
      child: Consumer(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}

class ProviderWidget2<A extends ChangeNotifier, B extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, A model1, B model2, Widget child) builder;
  final A model1;
  final B model2;
  final Widget child;
  final Function(A, B) onModelReady;

  ProviderWidget2({
    Key key,
    @required this.builder,
    @required this.model1,
    @required this.model2,
    this.child,
    this.onModelReady,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProviderWidget2State<A, B>();
}

class _ProviderWidget2State<A extends ChangeNotifier, B extends ChangeNotifier>
    extends State<ProviderWidget2<A, B>> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}