import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:ykos_bbq_chicken/Service/fire_firestore.dart';
import 'package:ykos_bbq_chicken/Service/fire_auth.dart';
import 'package:ykos_bbq_chicken/model/adress.dart';
import 'package:ykos_bbq_chicken/model/adress_symbol.dart';
import 'package:ykos_bbq_chicken/model/food.dart';
import 'package:ykos_bbq_chicken/model/category.dart';

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
  });
}
