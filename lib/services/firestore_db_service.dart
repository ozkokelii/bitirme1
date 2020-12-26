import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_lovers/model/mesaj.dart';
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

  @override
  Future<List> getAllUsers() async {
    QuerySnapshot querySnapshot = await _firebaseDB.collection("users").get();

    List<Kullanici> tumKullanicilar = [];
    for (DocumentSnapshot tekUser in querySnapshot.docs) {
      Kullanici _tekUser = Kullanici.fromMap(tekUser.data());
      tumKullanicilar.add(_tekUser);
    }
    return tumKullanicilar;
  }
/*
  @override
  Stream<Mesaj> getMessages(String currentUserID, String sohbetEdilenUserID) {
    var snapShot = _firebaseDB
        .collection("konusmalar")
        .doc(currentUserID + "--" + sohbetEdilenUserID)
        .collection("mesajlar")
        .doc(currentUserID)
        .snapshots();
    return snapShot.map((snapShot) => Mesaj.fromMap(snapShot.data));
  }
*/

  @override
  Stream<List<Mesaj>> getMessages(
      String currentUserID, String sohbetEdilenUserID) {
    var snapShot = _firebaseDB
        .collection("konusmalar")
        .doc(currentUserID + "--" + sohbetEdilenUserID)
        .collection("mesajlar")
        .orderBy("date", descending: true)
        .snapshots();
    return snapShot.map((mesajListesi) =>
        mesajListesi.docs.map((mesaj) => Mesaj.fromMap(mesaj.data())).toList());
  }

  Future<bool> saveMessage(Mesaj kaydedilecekMesaj) async {
    var _mesajID = _firebaseDB.collection("konuşmalar").doc().id;
    var _myDocumentID =
        kaydedilecekMesaj.kimden + "--" + kaydedilecekMesaj.kime;
    var _receiverDocumentID =
        kaydedilecekMesaj.kime + "--" + kaydedilecekMesaj.kimden;

    var _kaydedilecekMesajMapYapisi = kaydedilecekMesaj.toMap();

    await _firebaseDB
        .collection("konuşmalar")
        .doc(_myDocumentID)
        .collection("mesajlar")
        .doc(_mesajID)
        .set(_kaydedilecekMesajMapYapisi);

    _kaydedilecekMesajMapYapisi.update("bendenMi", (deger) => false);

    await _firebaseDB
        .collection("konuşmalar")
        .doc(_receiverDocumentID)
        .collection("mesajlar")
        .doc(_mesajID)
        .set(_kaydedilecekMesajMapYapisi);

    return true;
  }
}
