import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_lovers/services/auth_base.dart';
import 'package:flutter_lovers/user/user_model.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Kullanici> currentUser() async {
    try {
      User kullanici = _firebaseAuth.currentUser;
      return _userFromFirebase(kullanici);
    } catch (e) {
      print("HATA CURRENT USER " + e.toString());
      return null;
    }
  }

  Kullanici _userFromFirebase(User kullanici) {
    if (kullanici == null) {
      return null;
    } else {
      return Kullanici(
        kullaniciID: kullanici.uid,
      );
    }
  }

  @override
  Future<Kullanici> signInAnonymously() async {
    try {
      UserCredential sonuc = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(sonuc.user);
    } catch (e) {
      print("ananonim giriş hata" + e.toString());
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("signout hata" + e.toString());
      return false;
    }
  }
}
