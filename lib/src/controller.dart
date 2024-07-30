import '../results/rozetka_pay_cc_token.dart';
import '../results/rozetka_pay_err_type.dart';
import '../results/rozetka_pay_result.dart';
import '../rozetka_pay_params.dart';
import 'cc/cc_utils.dart';
import 'cc/cc_validator.dart';
import 'cc/credit_card.dart';
import 'api/api.dart';
import 'utils/log.dart';
import 'wg/core/notifiers/obj_value_notifier.dart';

class Controller {
  // params
  final RozetkaPayParams params;
  // value notifiers
  final ccVn = ObjValueNotifier(CreditCard("", "", ""));
  // dependencies
  late final _api = Api(params.api);

  Controller(this.params) {
    Log.level = params.logLevel.level;
  }

  void onNumIn(String num) => ccVn.update((cc) => cc.num = num);
  void onExpIn(String expiry) => ccVn.update((cc) => cc.exp = expiry);
  void onCvvIn(String cvv) => ccVn.update((cc) => cc.cvv = cvv);

  bool isActionAllowed(CreditCard cc) => CcValidator.isConsistent(cc);

  // let widget client know about starting execution the action
  Future<void> onAction(CreditCard src) async {
    final future = _tryAction(src);
    params.onAction(future);
    await future;
  }

  Future<RozetkaPayResult<RozetkaPayCcToken>> _tryAction(CreditCard src) async {
    try {
      return _doAction(src);
    } catch (err) {
      return RozetkaPayResult.err(
        RozetkaPayErrType.unkown,
        errMsg: err.toString(),
      );
    }
  }

  Future<RozetkaPayResult<RozetkaPayCcToken>> _doAction(CreditCard src) async {
    CreditCard cc = CcUtils.normalize(src);
    RozetkaPayErrType? err = CcValidator.validate(cc);
    if (err != null) return RozetkaPayResult.err(err);

    ///
    RozetkaPayResult res = await _api.getToken(cc.num, cc.exp, cc.cvv);
    return (!res.isOk)
        ? RozetkaPayResult.err(res.errType!, errMsg: res.errMsg)
        : RozetkaPayResult.ok(
            RozetkaPayCcToken(
              mask: CcUtils.mask(cc.num),
              exp: cc.exp,
              token: res.data,
            ),
          );
  }
}
