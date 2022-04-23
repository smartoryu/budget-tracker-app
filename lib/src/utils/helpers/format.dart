import 'package:intl/intl.dart';

class Format {
  /// Format number to rupiah
  ///
  /// `double` number
  ///
  /// return example: Rp 150.000
  static String currency(double number) {
    NumberFormat formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: "Rp ",
      decimalDigits: 0,
    );
    return formatCurrency.format(number);
  }

  /// format date to locale
  ///
  /// `DateTime` date  |  `string` format (default: "`dd MMMM yyyy, HH:mm`")
  static String date(
    DateTime _date, [
    String format = "dd MMMM yyyy, HH:mm",
  ]) {
    var dateTime = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(
      _date.toIso8601String(),
      true,
    );
    var dateLocal = dateTime.toLocal();
    return DateFormat(format, "id-ID").format(dateLocal);
  }
}
