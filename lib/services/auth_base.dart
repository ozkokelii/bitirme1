import 'package:flutter_lovers/model/user_model.dart';

abstract class AuthBase {
  Future<Kullanici> currentUser();
  Future<Kullanici> signInAnonymously();
  Future<bool> signOut();
  Future<Kullanici> signInWithGoogle();
  Future<Kullanici> signInWithFacebook();
  Future<Kullanici> signInWithEmailAndPassword(String email, String sifre);
  Future<Kullanici> createUserWithEmailAndPassword(String email, String sifre);
}
