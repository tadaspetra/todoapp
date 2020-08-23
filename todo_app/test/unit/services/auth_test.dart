import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/services/auth.dart';

class MockUser extends Mock implements User {
  @override
  String get uid => "1234";
}

MockUser _mockUser = MockUser();

class MockAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User> authStateChanges() {
    return Stream.fromIterable(
      [
        _mockUser,
      ],
    );
  }

  @override
  User get currentUser => MockUser();
}

class MockUserCredential extends Mock implements UserCredential {
  @override
  User get user => MockUser();
}

void main() {
  final MockAuth _mockAuth = MockAuth();
  setUp(() {});

  tearDown(() {});

  test("Create Account", () async {
    when(_mockAuth.createUserWithEmailAndPassword(
            email: "tadas@gmail.com", password: "123456"))
        .thenAnswer(
      (realInvocation) => Future.value(
        MockUserCredential(),
      ),
    );

    final Auth auth = Auth(auth: _mockAuth);
    expectLater(auth.user, emitsInOrder([_mockUser]));
    auth.createAccount(email: "tadas@gmail.com", password: "123456");
  });
  test("Sign in user", () async {
    when(_mockAuth.signInWithEmailAndPassword(
            email: "tadas@gmail.com", password: "123456"))
        .thenAnswer(
      (realInvocation) => Future.value(
        MockUserCredential(),
      ),
    );

    final Auth auth = Auth(auth: _mockAuth);
    expectLater(auth.user, emitsInOrder([_mockUser]));
    auth.signIn(email: "tadas@gmail.com", password: "123456");
  });

  test("Sign out user", () async {
    when(_mockAuth.signOut()).thenAnswer(
      (realInvocation) => Future.value(),
    );

    final Auth auth = Auth(auth: _mockAuth);
    expectLater(auth.user, neverEmits([_mockUser]));
    auth.signOut();
  });
}
