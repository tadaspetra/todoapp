import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/services/auth.dart';

class MockUser extends Mock implements User {}

final MockUser _mockUser = MockUser();

class MockAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User> authStateChanges() {
    return Stream.fromIterable(
      [
        _mockUser,
      ],
    );
  }
}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  final MockAuth mockAuth = MockAuth();
  setUp(() {});
  tearDown(() {});

  test("create account", () {
    when(
      mockAuth.createUserWithEmailAndPassword(
        email: "tadas@gmail.com",
        password: "123456",
      ),
    ).thenAnswer(
      (realInvocation) => Future.value(
        MockUserCredential(),
      ),
    );
    final Auth auth = Auth(auth: mockAuth);
    expectLater(auth.user, emitsInOrder([_mockUser]));

    auth.createAccount(email: "tadas@gmail.com", password: "123456");
  });

  test("sign in", () {
    when(
      mockAuth.signInWithEmailAndPassword(
        email: "tadas@gmail.com",
        password: "123456",
      ),
    ).thenAnswer(
      (realInvocation) => Future.value(
        MockUserCredential(),
      ),
    );
    final Auth auth = Auth(auth: mockAuth);
    expectLater(auth.user, emitsInOrder([_mockUser]));

    auth.signIn(email: "tadas@gmail.com", password: "123456");
  });

  test("signOut", () {
    when(
      mockAuth.signOut(),
    ).thenAnswer((realInvocation) => Future.value());
    final Auth auth = Auth(auth: mockAuth);
    expectLater(auth.user, neverEmits([_mockUser]));

    auth.signOut();
  });
}
