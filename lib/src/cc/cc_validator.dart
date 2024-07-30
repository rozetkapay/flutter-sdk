import '../../results/rozetka_pay_err_type.dart';

import 'credit_card.dart';

class CcValidator {
  static RozetkaPayErrType? validate(CreditCard cc) {
    if (!isValidByLuhn(cc.num)) {
      return RozetkaPayErrType.invalidCcNum;
    }
    if (!isExpireValid(cc.exp)) {
      return RozetkaPayErrType.invalidCcExp;
    }
    return null;
  }

  /// 19 = '1111 2222 3333 4444'
  /// 5  = '01/25'
  static bool isConsistent(CreditCard cc) =>
      cc.num.trim().length == 19 &&
      cc.exp.trim().length == 5 &&
      cc.cvv.trim().length == 3;

  /// Luhn algorithm
  static bool isValidByLuhn(String num) {
    int sum = 0;
    bool alternate = false;

    for (int i = num.length - 1; i >= 0; i--) {
      int digit = int.parse(num[i]);

      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit = (digit % 10) + 1;
        }
      }

      sum += digit;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }

  static bool isExpireValid(String exp) {
    if (exp.length != 4) {
      return false;
    }
    int expMonth = int.tryParse(exp.substring(0, 2)) ?? 0;
    if (expMonth < 1 || expMonth > 12) {
      return false;
    }
    int expYear = int.tryParse('20${exp.substring(2, 4)}') ?? 0;
    DateTime now = DateTime.now();
    int nowYear = now.year;
    int nowMonth = now.month;

    if (expYear > nowYear || (expYear == nowYear && expMonth >= nowMonth)) {
      // The card is valid if the year is greater than the current year,
      // or if it's the same year but the month is greater than or equal to the current month.
      return true;
    }
    return false;
  }
}
