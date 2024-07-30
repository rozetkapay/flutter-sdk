import 'card_type.dart';
import 'cc_utils.dart';

class CreditCard {
  String num;
  String exp;
  String cvv;

  CreditCard(this.num, this.exp, this.cvv);

  CardType? type() => CcUtils.cardType(num);
}
