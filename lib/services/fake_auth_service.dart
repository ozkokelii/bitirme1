import 'package:flutter_lovers/model/user.dart';
import 'package:flutter_lovers/services/auth_base.dart';

class FakeAuthService implements AuthBase {
  String kullaniciID = "71547154";

  @override
  Future<Kullanici> currentUser() async {
    return await Future.value(
        Kullanici(kullaniciID: kullaniciID, email: "fakekullanici@fake.com"));
  }

  @override
  Future<Kullanici> signInAnonymously() async {
    return await Future.delayed(
        Duration(seconds: 2),
        () => Kullanici(
            kullaniciID: kullaniciID, email: "fakekullanici@fake.com"));
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<Kullanici> signInWithGoogle() async {
    return await Future.delayed(
        Duration(seconds: 2),
        () => Kullanici(
            kullaniciID: "google_user_id_121212",
            email: "fakekullanici@fake.com"));
  }

  @override
  Future<Kullanici> signInWithFacebook() async {
    return await Future.delayed(
        Duration(seconds: 2),
        () => Kullanici(
            kullaniciID: "facebook_user_id_12121212",
            email: "fakekullanici@fake.com"));
  }

  @override
  Future<Kullanici> createUserWithEmailAndPassword(
      String email, String sifre) async {
    return await Future.delayed(
        Duration(seconds: 2),
        () => Kullanici(
            kullaniciID: "created_user_id_131331",
            email: "fakekullanici@fake.com"));
  }

  @override
  Future<Kullanici> signInWithEmailAndPassword(
      String email, String sifre) async {
    return await Future.delayed(
        Duration(seconds: 2),
        () => Kullanici(
            kullaniciID: "signin_user_id_141414",
            email: "fakekullanici@fake.com"));
  }
}
