import 'rozetka_pay_err_type.dart';

class RozetkaPayResult<T> {
  final T? data;

  final RozetkaPayErrType? errType;
  final String? errMsg;

  bool get isOk => errType == null;

  RozetkaPayResult({this.data, this.errType, this.errMsg});

  RozetkaPayResult.ok(T? data) : this(data: data);

  RozetkaPayResult.err(RozetkaPayErrType type, {String? errMsg})
      : this(errType: type, errMsg: errMsg);
}
