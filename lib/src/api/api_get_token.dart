import 'package:http/http.dart' as http;
import 'package:rozetkapay_flutter_sdk/src/utils/sys_info.dart';

import '../../results/rozetka_pay_result.dart';
import '../cc/cc_utils.dart';
import 'api_base.dart';

class ApiGetToken extends ApiBase {
  static const _path = "api/v1/sdk/tokenize";

  final _sysInfo = SysInfo();

  ApiGetToken(super.params);

  Future<RozetkaPayResult<String>> req(
          String cc, String exp, String cvv) async =>
      _handle(await post(
        _path,
        _body(cc, exp, cvv, await _sysInfo.get()),
      ));

  Map<String, dynamic> _body(
    String cc,
    String exp,
    String cvv,
    Map<String, String> sysInfo,
  ) =>
      {
        "card_number": cc,
        "card_exp_month": CcUtils.expM(exp),
        "card_exp_year": CcUtils.expY(exp),
        "card_cvv": cvv,
        "rich": false,
        ...sysInfo,
      };

  RozetkaPayResult<String> _handle(http.Response res) =>
      isOk(res) ? _onOk(res) : onErr(res);

  RozetkaPayResult<String> _onOk(http.Response res) =>
      RozetkaPayResult.ok(json(res)!["token"]);
}
