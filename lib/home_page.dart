import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final User kullanici;
  final Function onSignOut;

  HomePage({Key key, this.kullanici, @required this.onSignOut})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
              onPressed: _cikisYap,
              child: Text(
                "Çıkış Yap",
                style: TextStyle(color: Colors.white),
              ))
        ],
        title: Text("Ana Sayfa"),
      ),
      body: Center(child: Text("Hoşgeldiniz ${kullanici.uid}")),
    );
  }

  Future<void> _cikisYap() async {
    await FirebaseAuth.instance.signOut();
    onSignOut();
  }
}
