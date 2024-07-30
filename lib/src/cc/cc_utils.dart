import 'card_type.dart';
import 'credit_card.dart';

class CcUtils {
  static CreditCard normalize(CreditCard src) => CreditCard(
      src.num.replaceAll(' ', ''), src.exp.replaceFirst('/', ''), src.cvv);

  static CardType? cardType(String num) {
    if (num.isEmpty) return null;
    if (num.startsWith('4')) return CardType.visa;
    if (in_51_55(num) || in_2221_2720(num)) return CardType.mc;
    return null;
  }

  static int expM(String exp) => int.parse(exp.substring(0, 2));
  static int expY(String exp) => int.parse(exp.substring(2));

  /// << 4242424242424242
  /// => 424242******4242
  static String mask(String num) => num.replaceRange(6, 12, '*' * 6);

  static int _first2(String num) => _firstN(num, 2);
  static int _first4(String num) => _firstN(num, 4);
  static int _firstN(String num, int x) => int.parse(num.substring(0, x));

  static bool in_2221_2720(String num) =>
      (num.length >= 4 && _first4(num) >= 2221 && _first4(num) <= 2720);

  static bool in_51_55(String num) =>
      (num.length >= 2 && _first2(num) >= 51 && _first2(num) <= 55);
}
