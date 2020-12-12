import 'package:flutter_lovers/model/user_model.dart';
import 'package:flutter_lovers/services/auth_base.dart';

class FakeAuthService implements AuthBase {
  String kullaniciID = "71547154";

  @override
  Future<Kullanici> currentUser() async {
    return await Future.value(Kullanici(kullaniciID: kullaniciID));
  }

  @override
  Future<Kullanici> signInAnonymously() async {
    return await Future.delayed(
        Duration(seconds: 2), () => Kullanici(kullaniciID: kullaniciID));
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<Kullanici> signInWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<Kullanici> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<Kullanici> createUserWithEmailAndPassword(String email, String sifre) {
    // TODO: implement createUserWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Kullanici> signInWithEmailAndPassword(String email, String sifre) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }
}
