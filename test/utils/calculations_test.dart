import 'package:flutter_test/flutter_test.dart';
import 'package:ykos_bbq_chicken/model/order_summary.dart';
import 'package:ykos_bbq_chicken/model/food.dart';
import 'package:ykos_bbq_chicken/model/category.dart';
import 'package:ykos_bbq_chicken/enum/category_enum.dart';

void main() {
  group('OrderSummary calculations', () {
    test('should calculate prices and taxes correctly', () {
      final foods = [
        Food(
          artikelNr: 'A1',
          name: 'BBQ Chicken',
          description: 'Delicious grilled chicken',
          category: Category(name: CategoryEnum.chicken.label, categoryImg: ''),
          imgAsset: null,
          price: 10.0,
          labels: [],
          allergens: [],
          count: 2, // zwei Portionen à 10€
        ),
        Food(
          artikelNr: 'D1',
          name: 'Cola',
          description: 'Soft drink',
          category: Category(
            name: CategoryEnum.drinks.label.toLowerCase(),
            categoryImg: '',
          ),
          imgAsset: null,
          price: 10.0,
          labels: [],
          allergens: [],
          count: 1,
        ),
      ];

      final summary = OrderSummary(
        foods: foods,
        discount: 0.1, // 10% Rabatt
        deliveryCharge: 2.5,
      );

      // 10*2 + 10*1 = 30
      expect(summary.basisPreis, 30.0);

      // Rabatt 10% von 30 = 3.0
      expect(summary.rabattBetrag, 3.0);

      // Netto (nach Rabatt, vor Lieferkosten)
      expect(summary.nettoPreis, 27.0);

      // Endsumme + Lieferkosten
      expect(summary.endSumme, 29.5);

      // 7% MwSt auf Speisen (20€ mit Rabatt -> 18€ netto)
      // 18 * 0.07 = 1.26
      expect(summary.essenMwst, closeTo(1.26, 0.001));

      // 19% MwSt auf Getränke (10€ mit Rabatt -> 9.0€)
      // 9.0 * 0.19 = 1.71
      expect(summary.getraenkeMwst, closeTo(1.71, 0.01));

      // Gesamt MwSt
      expect(summary.gesamtMwst, closeTo(2.97, 0.05));
    });
  });
}

// // OrderSummery calculate functions
// double calculateTotal(double price, int quantity) {
//   return price * quantity;
// }

// double applyDiscount(double total, double discountRate) {
//   return total * (1 - discountRate);
// }
