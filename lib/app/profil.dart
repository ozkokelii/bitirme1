import 'package:flutter/material.dart';
import 'package:flutter_lovers/common_widget/platform_duyarli_alert_dialog.dart';
import 'package:flutter_lovers/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    print(
        "Profil sayfasındaki user değerleri" + _userModel.kullanici.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        actions: [
          FlatButton(
              onPressed: () => _cikisIcinOnayIste(context),
              child: Text(
                "Çıkış",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ))
        ],
      ),
      body: Center(
        child: Text("Profil Sayfası"),
      ),
    );
  }

  Future<bool> _cikisYap(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    bool sonuc = await _userModel.signOut();
    return sonuc;
  }

  Future _cikisIcinOnayIste(BuildContext context) async {
    final sonuc = await PlatformDuyarliAlertDialog(
      baslik: "Emin misiniz ?",
      icerik: "Çıkamk istediğinize emin misiniz ?",
      anaButonYazisi: "Evet",
      iptalButonYazisi: "Vazgeç",
    ).goster(context);

    if (sonuc == true) {
      _cikisYap(context);
    }
  }
}
