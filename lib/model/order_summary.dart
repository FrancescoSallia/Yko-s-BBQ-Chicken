import 'package:ykos_bbq_chicken/model/food.dart';

class OrderSummary {
  final List<Food> foods; // Alle Gerichte
  final double? discount; // optionaler Rabatt, z. B. 0.10 für 10%
  final double deliveryCharge; // z. B. 2.50
  final double tax; // z. B. 0.19 für 19%

  OrderSummary({
    required this.foods,
    this.discount, // nullable
    this.deliveryCharge = 0.0,
    this.tax = 0.19,
  });

  /// 1️⃣ Basispreis: alle Gerichte inkl. Extras ohne Rabatt oder Lieferkosten
  double get basisPreis =>
      foods.fold(0.0, (sum, food) => sum + food.totalWithExtras);

  /// 2️⃣ Rabattbetrag in Euro (0.0 wenn kein Rabatt)
  double get rabattBetrag => (discount ?? 0.0) * basisPreis;

  /// 3️⃣ Preis nach Rabatt, vor Lieferkosten
  double get nettoPreis => basisPreis - rabattBetrag;

  /// 4️⃣ Endsumme inklusive Lieferkosten
  double get endSumme => nettoPreis + deliveryCharge;

  /// 5️⃣ MwSt. Betrag (auf Endsumme)
  double get mwstBetrag => endSumme * tax;

  /// 6️⃣ Preis inkl. MwSt
  double get endSummeMitMwSt => endSumme;
}
