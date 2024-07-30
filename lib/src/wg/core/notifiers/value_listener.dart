import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ValueListener<T> extends ValueListenableBuilder<T> {
  ValueListener({
    required ValueListenable<T> notifier,
    required Widget Function(BuildContext ctx, T newValue) builder,
    super.key,
  }) : super(
          valueListenable: notifier,
          builder: (ctx, newValue, _) => builder(ctx, newValue),
        );
}
