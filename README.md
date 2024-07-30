# rozetkapay_flutter_sdk

```dart
  RozetkaPayWg(
      RozetkaPayParams(
        api: RozetkaPayApiParams(
          host: "widget-epdev.rozetkapay.com",
          key: "your_widget_key",
        ),
        onAction: onResult,
      ),
    );
  }

  void onResult(
    Future<RozetkaPayResult<RozetkaPayCcToken>> future,
  ) async {
    final result = await future;
    if (!result.isOk) {
      print("Error: ${res.errType} : ${res.errMsg}");
    } else {
      RozetkaPayCcToken data = result.data!;
      print("Success: token=${data.token}, mask=${data.mask} exp=${data.exp}");
    }
  }
