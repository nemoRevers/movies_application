import 'package:flutter/material.dart';

class NotifierProvider<Model extends ChangeNotifier> extends InheritedNotifier {
  final Model model;

  const NotifierProvider({Key? key, required this.model, required Widget child})
      : super(key: key, notifier: model, child: child);

  static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    final Model? result = context
        .dependOnInheritedWidgetOfExactType<NotifierProvider<Model>>()
        ?.model;
    assert(result != null, 'No GroupFormWidgetProvider found in context');
    return result;
  }

  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final Widget? widget = context
        .getElementForInheritedWidgetOfExactType<NotifierProvider<Model>>()
        ?.widget;
    return widget is NotifierProvider<Model> ? widget.model : null;
  }
}

class Provider<Model> extends InheritedWidget {
  final Model model;
  const Provider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child);

  static Model? watch<Model>(BuildContext context) {
    final Model? result =
        context.dependOnInheritedWidgetOfExactType<Provider<Model>>()?.model;
    assert(result != null, 'No GroupFormWidgetProvider found in context');
    return result;
  }

  static Model? read<Model>(BuildContext context) {
    final Widget? widget = context
        .getElementForInheritedWidgetOfExactType<Provider<Model>>()
        ?.widget;
    return widget is Provider<Model> ? widget.model : null;
  }

  @override
  bool updateShouldNotify(Provider old) {
    return model != old.model;
  }
}
