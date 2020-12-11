import 'package:flutter_lovers/user/user_model.dart';

abstract class AuthBase {
  Future<Kullanici> currentUser();
  Future<Kullanici> signInAnonymously();
  Future<bool> signOut();
}
