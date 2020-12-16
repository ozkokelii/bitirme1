import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Kullanici {
  final String kullaniciID;
  String email;
  String userName;
  String profilURL;
  DateTime createdAt;
  DateTime updatedAt;
  int seviye;

  Kullanici({@required this.kullaniciID, @required this.email});

  Map<String, dynamic> toMap() {
    return {
      "kullaniciID": kullaniciID,
      "email": email,
      "userName": userName ?? " ",
      "profilURL": profilURL ??
          "https://www.flaticon.com/svg/static/icons/svg/81/81591.svg",
      "createdAt": createdAt ?? FieldValue.serverTimestamp(),
      "updateAt": updatedAt ?? FieldValue.serverTimestamp(),
      "seviye": seviye ?? 1,
    };
  }

  Kullanici.fromMap(Map<String, dynamic> map)
      : kullaniciID = map["kullaniciID"],
        email = map["email"],
        userName = map["userName"],
        profilURL = map["profilURL"],
        createdAt = (map["createdAt"] as Timestamp).toDate(),
        updatedAt = (map["updateAt"] as Timestamp).toDate(),
        seviye = map["seviye"];

  @override
  String toString() {
    return 'Kullanici{kullaniciID: $kullaniciID, email: $email, userName: $userName, profilURL: $profilURL, createdAt: $createdAt, updatedAt: $updatedAt, seviye: $seviye}';
  }
}
