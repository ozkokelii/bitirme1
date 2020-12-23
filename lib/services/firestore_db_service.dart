import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_lovers/model/user.dart';
import 'package:flutter_lovers/services/database_base.dart';

class FirestoreDBService implements DBBase {
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;

  @override
  Future<bool> saveUser(Kullanici kullanici) async {
    await _firebaseDB
        .collection("users")
        .doc(kullanici.kullaniciID)
        .set(kullanici.toMap());

    DocumentSnapshot _okunanUser = await FirebaseFirestore.instance
        .doc("users/${kullanici.kullaniciID}")
        .get();

    Map _okunanUserBilgileriMap = _okunanUser.data();
    Kullanici _okunanUserBilgileriNesne =
        Kullanici.fromMap(_okunanUserBilgileriMap);
    print("okunan user nesnesi : " + _okunanUserBilgileriNesne.toString());

    return true;
  }

  @override
  Future<Kullanici> readUser(String kullaniciID) async {
    DocumentSnapshot _okunanUser =
        await _firebaseDB.collection("users").doc(kullaniciID).get();
    Map<String, dynamic> _okunanUserBilgileriMap = _okunanUser.data();

    Kullanici _okunanUserNesnesi = Kullanici.fromMap(_okunanUserBilgileriMap);
    print("Okunan user nesnesi" + _okunanUserNesnesi.toString());
    return _okunanUserNesnesi;
  }

  @override
  Future<bool> updateUserName(String kullaniciID, String yeniUserName) async {
    var users = await _firebaseDB
        .collection("users")
        .where("username", isEqualTo: yeniUserName)
        .get();
    if (users.docs.length >= 1) {
      return false;
    } else {
      await _firebaseDB
          .collection("users")
          .doc(kullaniciID)
          .update({"userName": yeniUserName});
      return true;
    }
  }

  @override
  Future<bool> updateProfilFoto(
      String kullaniciID, String profilFotoURL) async {
    await _firebaseDB
        .collection("users")
        .doc(kullaniciID)
        .update({"profilURL": profilFotoURL});
    return true;
  }
}
