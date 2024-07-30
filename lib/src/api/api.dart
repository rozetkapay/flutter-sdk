import '../../rozetka_pay_params.dart';
import '../../results/rozetka_pay_result.dart';
import 'api_get_token.dart';

class Api {
  final RozetkaPayApiParams params;

  Api(this.params);

  late final _apiGetToken = ApiGetToken(params);

  Future<RozetkaPayResult<String>> getToken(
          String cc, String exp, String cvv) =>
      _apiGetToken.req(cc, exp, cvv);
}
