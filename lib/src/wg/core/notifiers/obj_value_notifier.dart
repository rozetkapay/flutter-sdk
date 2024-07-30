import 'package:flutter/material.dart';

class ObjValueNotifier<T> extends ValueNotifier<T> {
  ObjValueNotifier(super.value);

  void update(Function(T obj) setter) {
    setter(value);
    notifyListeners();
  }
}
