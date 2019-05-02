import 'package:firebase_auth/firebase_auth.dart';
import 'package:bookido/common/types.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class BookidoAuth {
  Future<BookidoUser> registerUserWithEmail(String email, String password, String name) async {
    return _auth.createUserWithEmailAndPassword(email: email, password: password)
      .then((user) {
        var info = new UserUpdateInfo();
        info.displayName = name;
        user.updateProfile(info);
        return BookidoUser(user.email, name, user.uid);
      })
      .catchError((error) {
        print(error);
        return null;
      });
  }

  Future<BookidoUser> signInWithEmail(String email, String password) async {
    return _auth.signInWithEmailAndPassword(email: email, password: password)
      .then((user) {
        return BookidoUser(user.email, user.displayName, user.uid);
      })
      .catchError((error) {
        print(error);
        return false;
      });
  }
}