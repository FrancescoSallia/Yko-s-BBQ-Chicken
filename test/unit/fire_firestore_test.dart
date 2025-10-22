import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:ykos_bbq_chicken/Service/fire_firestore.dart';
import 'package:ykos_bbq_chicken/Service/fire_auth.dart';
import 'package:ykos_bbq_chicken/enum/order_status_enum.dart';
import 'package:ykos_bbq_chicken/model/adress.dart';
import 'package:ykos_bbq_chicken/model/adress_symbol.dart';
import 'package:ykos_bbq_chicken/model/food.dart';
import 'package:ykos_bbq_chicken/model/category.dart';
import 'package:ykos_bbq_chicken/model/order.dart';
import 'package:ykos_bbq_chicken/model/order_summary.dart';
import 'package:ykos_bbq_chicken/model/payment.dart';
import 'package:ykos_bbq_chicken/model/user.dart';

void main() {
  late MockFirebaseAuth mockAuth;
  late FakeFirebaseFirestore fakeFirestore;
  late FireFirestore fireFirestore;

  setUp(() async {
    final user = MockUser(email: 'test@example.com', uid: 'user123');
    mockAuth = MockFirebaseAuth(mockUser: user);
    FireAuth.auth = mockAuth;

    fakeFirestore = FakeFirebaseFirestore();
    FireFirestore.firestore = fakeFirestore;

    // Einloggen, damit currentUser nicht null ist
    await FireAuth.auth.signInWithEmailAndPassword(
      email: 'test@example.com',
      password: '123456',
    );

    fireFirestore = FireFirestore();
  });

  group('Favorites Tests', () {
    test('addFavorite and fetchFavorites', () async {
      final food = Food(
        artikelNr: 'A1',
        name: 'BBQ Chicken',
        description: 'Delicious',
        category: Category(name: 'Chicken', categoryImg: ''),
        imgAsset: null,
        price: 10.0,
        labels: [],
        allergens: [],
        count: 1,
      );

      await fireFirestore.addFavorite(food);

      final favorites = await fireFirestore.fetchFavorites();
      expect(favorites.length, 1);
      expect(favorites.first.name, 'BBQ Chicken');
    });

    test('removeFromFavorite works', () async {
      final food = Food(
        artikelNr: 'A1',
        name: 'BBQ Chicken',
        description: 'Delicious',
        category: Category(name: 'Chicken', categoryImg: ''),
        imgAsset: null,
        price: 10.0,
        labels: [],
        allergens: [],
        count: 1,
      );

      await fireFirestore.addFavorite(food);
      await fireFirestore.removeFromFavorite(food);

      final favorites = await fireFirestore.fetchFavorites();
      expect(favorites.length, 0);
    });

    test("add new Adress & fetch all adresses", () async {
      final adress = Adress(
        name: "Test Tester",
        telefon: "017653446",
        street: "Teststreet",
        houseNumber: "12a",
        plz: "12123",
        place: "Berlin",
        icon: AdressSymbol(name: "Suit", iconData: Icons.home),
        information: "pls dont ring",
      );

      await fireFirestore.addAdress(adress);
      final adressList = await fireFirestore.fetchAdress();
      expect(adressList.length, 1);
      expect(adressList, isNotEmpty);
    });

    test("remove from AdressList", () async {
      final adress = Adress(
        name: "Test Tester",
        telefon: "017653446",
        street: "Teststreet",
        houseNumber: "12a",
        plz: "12123",
        place: "Berlin",
        icon: AdressSymbol(name: "Suit", iconData: Icons.home),
        information: "pls dont ring",
      );
      await fireFirestore.addAdress(adress);
      await fireFirestore.removeFromAdress(adress);
      final adressList = await fireFirestore.fetchAdress();
      expect(adressList.length, 0);
      expect(adressList, isEmpty);
    });

    test("update Adress", () async {
      final oldAdress = Adress(
        id: "1",
        name: "Test Tester",
        telefon: "017653446",
        street: "Teststreet",
        houseNumber: "12a",
        plz: "12123",
        place: "Berlin",
        icon: AdressSymbol(name: "Suit", iconData: Icons.home),
        information: "pls dont ring",
      );

      // Adresse hinzufügen
      await fireFirestore.addAdress(oldAdress);

      // Update: z. B. die Straße ändern
      final updatedAdress = Adress(
        id: "1",
        name: "Test Tester",
        telefon: "017653446",
        street: "New Street", // geändert
        houseNumber: "12a",
        plz: "12123",
        place: "Berlin",
        icon: AdressSymbol(name: "Suit", iconData: Icons.home),
        information: "pls dont ring",
      );

      await fireFirestore.updateAdress(updatedAdress);

      // Adressen abrufen
      final adressList = await fireFirestore.fetchAdress();

      // Prüfen, dass genau 1 Adresse vorhanden ist
      expect(adressList.length, 1);

      // Prüfen, dass die Adresse aktualisiert wurde
      final adress = adressList.first;
      expect(adress.id, "1");
      expect(adress.street, "New Street"); // wurde geupdated
      expect(adress.name, "Test Tester"); // Name bleibt gleich
    });

    test("add Order & fetch Orders in Firestore", () async {
      // Beispiel-Foods
      final foods = [
        Food(
          artikelNr: 'A1',
          name: 'BBQ Chicken',
          description: 'Leckeres gegrilltes Hähnchen',
          category: Category(name: 'Chicken', categoryImg: ''),
          imgAsset: null,
          price: 12.0,
          labels: ['Hot'],
          allergens: [],
          count: 2,
        ),
        Food(
          artikelNr: 'D1',
          name: 'Cola',
          description: 'Erfrischungsgetränk',
          category: Category(name: 'Drinks', categoryImg: ''),
          imgAsset: null,
          price: 2.5,
          labels: [],
          allergens: [],
          count: 1,
        ),
      ];
      final order = Order(
        pickUpUser: null,
        userId: 'user123',
        isDelivery: true,
        deliveryAdress: null, // optional, kann auch ein Adress-Objekt sein
        fastDeliveryTime: null,
        selectedTime: TimeOfDay(hour: 18, minute: 30),
        selectedDate: DateTime.now().add(Duration(days: 1)),
        payment: Payment(name: 'Bar', img: "lib/img/applepay.png"),
        orderSummary: OrderSummary(
          foods: foods,
          discount: 0.1,
          deliveryCharge: 2.5,
        ),
        orderStatus: OrderStatusEnum.recieved,
      );

      await fireFirestore.addOrder(order);
      final orderList = await fireFirestore.fetchOrders();
      expect(orderList.length, 1);
      expect(orderList, isNotEmpty);
    });
  });
}
