import 'package:flutter_lovers/model/user.dart';
import 'package:flutter_lovers/model/mesaj.dart';

abstract class DBBase {
  Future<bool> saveUser(Kullanici kullanici);

  Future<Kullanici> readUser(String kullaniciID);

  Future<bool> updateUserName(String kullaniciID, String yeniUserName);

  Future<bool> updateProfilFoto(String kullaniciID, String profilFotoURL);

  Future<List> getAllUsers();

  Stream<List<Mesaj>> getMessages(String currentUserID, String konusulanUserID);

  Future<bool> saveMessage(Mesaj kaydedilecekMesaj);
}
