import 'package:flutter/material.dart';

class StackAnimationProvider extends StatefulWidget {
  final Widget child;

  const StackAnimationProvider({Key key, this.child}) : super(key: key);

  static _StackAnimationProviderState ofState(BuildContext context) {
    return context.findAncestorStateOfType();
  }

  @override
  State<StatefulWidget> createState() {
    return _StackAnimationProviderState();
  }
}

class _StackAnimationProviderState extends State<StackAnimationProvider>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  ValueNotifier<bool> ignoreGesture = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
