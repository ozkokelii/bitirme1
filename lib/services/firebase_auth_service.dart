import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_lovers/model/user_model.dart';
import 'package:flutter_lovers/services/auth_base.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
        email: kullanici.email,
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
      final _googleSignIn = GoogleSignIn();
      await _googleSignIn.signOut();
      final _facebookLogin = FacebookLogin();
      await _facebookLogin.logOut();
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("signout hata" + e.toString());
      return false;
    }
  }

  @override
  Future<Kullanici> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        UserCredential sonuc = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: _googleAuth.idToken,
                accessToken: _googleAuth.accessToken));
        User _kullanici = sonuc.user;
        return _userFromFirebase(_kullanici);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<Kullanici> signInWithFacebook() async {
    final _facebookLogin = FacebookLogin();

    FacebookLoginResult _faceResult =
        await _facebookLogin.logIn(['public_profile', 'email']);

    switch (_faceResult.status) {
      case FacebookLoginStatus.loggedIn:
        if (_faceResult.accessToken.token != null) {
          UserCredential _firebaseResult = await _firebaseAuth
              .signInWithCredential(FacebookAuthProvider.credential(
                  _faceResult.accessToken.token));

          User _kullanici = _firebaseResult.user;
          return _userFromFirebase(_kullanici);
        } else {}

        break;

      case FacebookLoginStatus.cancelledByUser:
        print("kullanıcı facebook girişi iptal etti");
        break;

      case FacebookLoginStatus.error:
        print("Hata cıktı :" + _faceResult.errorMessage);
        break;
    }

    return null;
  }

  @override
  Future<Kullanici> createUserWithEmailAndPassword(
      String email, String sifre) async {
    try {
      UserCredential sonuc = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: sifre);
      return _userFromFirebase(sonuc.user);
    } catch (e) {
      print("kayıt ol hata" + e.toString());
      return null;
    }
  }

  @override
  Future<Kullanici> signInWithEmailAndPassword(
      String email, String sifre) async {
    try {
      UserCredential sonuc = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: sifre);
      return _userFromFirebase(sonuc.user);
    } catch (e) {
      print("email giriş hata" + e.toString());
      return null;
    }
  }
}
