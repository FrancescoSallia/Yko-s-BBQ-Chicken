import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ykos_bbq_chicken/Service/fire_auth.dart';
import 'package:ykos_bbq_chicken/model/food.dart';

class FireFirestore {
  static var firestore = FirebaseFirestore.instance;
  final auth = FireAuth.auth;

  /// Gibt immer die aktuelle Referenz für den eingeloggten Nutzer zurück.
  DocumentReference<Map<String, dynamic>> get userRef {
    final user = auth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'no-current-user',
        message: 'Kein Benutzer ist derzeit eingeloggt.',
      );
    }
    return firestore.collection("ykos_bbq_chicken").doc(user.uid);
  }

  Future<void> addFavorite(Food item) async {
    try {
      await userRef.collection('favorites').doc(item.id).set(item.toJson());
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> removeFromFavorite(Food item) async {
    try {
      await userRef.collection('favorites').doc(item.id).delete();
    } on FirebaseException {
      rethrow;
    }
  }

  Future<List<Food>> fetchFavorites() async {
    try {
      final snapshot = await userRef.collection("favorites").get();
      return snapshot.docs.map((doc) => Food.fromJson(doc.data())).toList();
    } on FirebaseException {
      rethrow;
    }
  }
}
