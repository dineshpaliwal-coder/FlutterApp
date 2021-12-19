import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class SocialChatFirebaseUser {
  SocialChatFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

SocialChatFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<SocialChatFirebaseUser> socialChatFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<SocialChatFirebaseUser>(
            (user) => currentUser = SocialChatFirebaseUser(user));
