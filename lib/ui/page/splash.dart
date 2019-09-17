import 'package:flutter/material.dart';
import 'package:fun_android/config/resource_manager.dart';
import 'package:fun_android/config/route_config.dart';
import 'package:fun_android/generated/i18n.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _logoController;
  Animation<double> _animation; //logo动画
  AnimationController _countdownController;
  Animation<int> _countdownAnimation; //倒计时动画

  @override
  void initState() {
    _logoController = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));

    _animation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _logoController, curve: Curves.easeInOutBack));

    _animation.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _logoController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _logoController.forward();
      }
    });

    _logoController.forward();

    _countdownController = AnimationController(vsync: this, duration: Duration(seconds: 4));
    _countdownController.forward();

    _countdownAnimation = StepTween(begin: 3, end: 0).animate(_countdownController);

    super.initState();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => Future.value(false), //屏蔽返回键
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              ImageHelper.wrapAssets('splash_bg.png'),
              fit: BoxFit.fill,
            ),
            //Flutter文字动画logo
            AnimatedFlutterLogo(
              animation: _animation,
            ),
            //fun和Android文字动画logo
            AnimatedAndroidLogo(
              animation: _animation,
            ),
            //倒计时
            Align(
              alignment: Alignment.bottomRight,
              child: SafeArea(
                child: InkWell(
                  onTap: () {
                    nextPage(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    margin: EdgeInsets.only(right: 20, bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.black.withAlpha(100),
                    ),
                    child: AnimatedCountDown(
                      animation: _countdownAnimation,
                      context: context,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void nextPage(BuildContext context) {
  Navigator.of(context).pushReplacementNamed(RouteName.tab);
}

class AnimatedFlutterLogo extends AnimatedWidget {
  AnimatedFlutterLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return AnimatedAlign(
      alignment: Alignment(0, 0.2 + animation.value * 0.3),
      duration: Duration(milliseconds: 10),
      curve: Curves.bounceOut,
      child: Image.asset(
        ImageHelper.wrapAssets('splash_flutter.png'),
        width: 280,
        height: 120,
      ),
    );
  }
}

class AnimatedAndroidLogo extends AnimatedWidget {
  AnimatedAndroidLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Align(
      alignment: Alignment(0.0, 0.7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            ImageHelper.wrapAssets('splash_fun.png'),
            width: 140 * animation.value,
            height: 80 * animation.value,
          ),
          Image.asset(
            ImageHelper.wrapAssets('splash_android.png'),
            width: 200 * (1 - animation.value),
            height: 80 * (1 - animation.value),
          )
        ],
      ),
    );
  }
}

class AnimatedCountDown extends AnimatedWidget {
  final Animation<int> animation;

  AnimatedCountDown({Key key, this.animation, BuildContext context})
      : super(key: key, listenable: animation) {
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        nextPage(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Animation<int> animation = listenable;
    var value = animation.value + 1;
    return Text(
      value == 0 ? '' : '$value | ' + S.of(context).splashSkip,
      style: TextStyle(color: Colors.white),
    );
  }
}
