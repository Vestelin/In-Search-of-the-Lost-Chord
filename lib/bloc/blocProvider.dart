import 'package:flutter/material.dart';

import 'bloc.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;
  final bool shouldDispose;
  const BlocProvider(
      {Key key,
      @required this.bloc,
      @required this.child,
      this.shouldDispose: true})
      : super(key: key);

  static T of<T extends Bloc>(BuildContext context) {
    final provider = context.findAncestorWidgetOfExactType<BlocProvider<T>>();
    return provider.bloc;
  }

  State createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    if (widget.shouldDispose) widget.bloc.dispose();
    super.dispose();
  }
}
