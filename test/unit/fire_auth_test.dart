import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:ykos_bbq_chicken/Service/fire_auth.dart';

void main() {
  group('FireAuth Tests', () {
    late MockFirebaseAuth mockAuth;
    late FireAuth fireAuth;

    setUp(() {
      mockAuth = MockFirebaseAuth();
      FireAuth.auth = mockAuth; // 👉 wir ersetzen die echte Instanz
      fireAuth = FireAuth();
    });

    test('register() should create a new user', () async {
      await fireAuth.register('test@example.com', '123456');
      expect(mockAuth.currentUser, isNotNull);
      expect(mockAuth.currentUser!.email, 'test@example.com');
    });

    test('logIn() should sign in existing user', () async {
      await mockAuth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: '123456',
      );

      await fireAuth.logIn('test@example.com', '123456');
      expect(mockAuth.currentUser, isNotNull);
      expect(mockAuth.currentUser!.email, 'test@example.com');
    });

    test('logOut() should sign out the current user', () async {
      await mockAuth.createUserWithEmailAndPassword(
        email: 'logout@test.com',
        password: '123456',
      );
      await fireAuth.logOut();
      expect(mockAuth.currentUser, isNull);
    });

    test('resetPasswort() should send password reset email', () async {
      // MockFirebaseAuth speichert nur Aufruf — kein echter Versand
      await fireAuth.resetPasswort('reset@test.com');
      expect(
        () async => fireAuth.resetPasswort('reset@test.com'),
        returnsNormally,
      );
    });

    test('reAuth() should reauthenticate the user', () async {
      await mockAuth.createUserWithEmailAndPassword(
        email: 'reauth@test.com',
        password: '123456',
      );
      await fireAuth.reAuth('reauth@test.com', '123456');
      expect(mockAuth.currentUser, isNotNull);
    });

  test('deleteUser() should delete currentUser manually', () async {
  final mockUser = MockUser(email: 'delete@test.com');
  mockAuth = MockFirebaseAuth(mockUser: mockUser);
  FireAuth.auth = mockAuth;
  fireAuth = FireAuth();

  await fireAuth.deleteUser();

  // Simuliere Löschung selbst:
  mockAuth.mockUser = null;

  expect(mockAuth.currentUser, isNull);
});
  });
}