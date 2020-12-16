import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_lovers/model/user_model.dart';
import 'package:flutter_lovers/services/database_base.dart';

class FirestoreDBService implements DBBase {
  final FirebaseFirestore _firebaseAuth = FirebaseFirestore.instance;

  @override
  Future<bool> saveUser(Kullanici kullanici) async {
    await _firebaseAuth
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
}
