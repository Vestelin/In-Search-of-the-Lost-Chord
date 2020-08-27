import 'package:flutter/material.dart';

class JumpingDot extends AnimatedWidget {
  JumpingDot({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Transform.translate(
      offset: Offset(0, -animation.value),
      child: Text('.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          )),
    );
  }
}

class JumpingDotsProgressIndicator extends StatefulWidget {
  final int numberOfDots;
  final double beginTweenValue;
  final double endTweenValue;
  final Color color;
  final double fontSize;
  final double dotSpacing;
  final int miliseconds;

  const JumpingDotsProgressIndicator(
      {Key key,
      this.numberOfDots: 3,
      this.beginTweenValue: 0.0,
      this.color: Colors.white,
      this.fontSize: 16.0,
      this.dotSpacing: 0.0,
      this.miliseconds: 200})
      : endTweenValue = fontSize / 4,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _JumpingDotsProgressIndicatorState();
  }
}

class _JumpingDotsProgressIndicatorState
    extends State<JumpingDotsProgressIndicator> with TickerProviderStateMixin {
  final List<AnimationController> controllers = List<AnimationController>();
  final List<Animation<double>> animations = List<Animation<double>>();
  final List<Widget> widgets = List<Widget>();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.numberOfDots; i++) {
      controllers.add(
        AnimationController(
          duration: Duration(milliseconds: widget.miliseconds),
          vsync: this,
        ),
      );
      animations.add(Tween(
        begin: widget.beginTweenValue,
        end: widget.endTweenValue,
      ).animate(controllers[i])
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            controllers[i].reverse();
          }
          if (i == widget.numberOfDots - 1 &&
              status == AnimationStatus.dismissed) {
            controllers[0].forward();
          }
          if (animations[i].value > widget.endTweenValue / 2 &&
              i < widget.numberOfDots - 1) {
            controllers[i + 1].forward();
          }
        }));
      widgets.add(Padding(
          padding: EdgeInsets.only(right: 1),
          child: JumpingDot(
            animation: animations[i],
          )));
    }
    controllers[0].forward();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controllers.forEach((element) => element.dispose());
  }
}
