import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AjuApplicationFirebaseUser {
  AjuApplicationFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

AjuApplicationFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<AjuApplicationFirebaseUser> ajuApplicationFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<AjuApplicationFirebaseUser>(
            (user) => currentUser = AjuApplicationFirebaseUser(user));
