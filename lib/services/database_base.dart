import 'package:flutter_lovers/model/user.dart';

abstract class DBBase {
  Future<bool> saveUser(Kullanici kullanici);
  Future<Kullanici> readUser(String kullaniciID);
  Future<bool> updateUserName(String kullaniciID, String yeniUserName);
}
