import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../results/rozetka_pay_err_type.dart';
import '../../rozetka_pay_params.dart';
import '../../results/rozetka_pay_result.dart';
import '../utils/log.dart';
import 'api_sign_utils.dart';

class ApiBase {
  static const _defaultHost = "https://widget.rozetkapay.com";

  final RozetkaPayApiParams params;

  ApiBase(this.params);

  Future<http.Response> post(String path, Map<String, dynamic> body) async {
    var uri = Uri.https(_host, path);
    var headers = _headers(body);
    var json = jsonEncode(body);
    //
    if (Log.isDebug()) Log.http("POST", uri, headers, json);
    var res = await http.post(uri, headers: headers, body: json);
    if (Log.isDebug()) Log.debug("${res.statusCode}:${res.body}");
    return res;
  }

  Map<String, String> _headers(Map<String, dynamic> body) => {
        "Content-Type": "application/json",
        "X-Widget-Id": _key,
        "X-Sign": ApiSignUtils.sign(body, _key),
      };

  Map<String, dynamic>? json(http.Response res) => jsonDecode(res.body);

  bool isOk(http.Response res) => 201 == res.statusCode;

  RozetkaPayResult<T> onErr<T>(http.Response res) =>
      RozetkaPayResult.err(RozetkaPayErrType.unkown, errMsg: err(res));

  String err(http.Response res) => "${res.statusCode}:${errMsg(res)}";

  String errMsg(http.Response res) => json(res)?["error_message"] ?? '';

  String get _host => params.host ?? _defaultHost;
  String get _key => params.key;
}
