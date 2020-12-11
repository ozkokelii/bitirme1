import 'package:flutter_lovers/services/auth_base.dart';
import 'package:flutter_lovers/user/user_model.dart';

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
}
