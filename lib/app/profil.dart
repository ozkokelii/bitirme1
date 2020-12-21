import 'package:flutter/material.dart';
import 'package:flutter_lovers/common_widget/platform_duyarli_alert_dialog.dart';
import 'package:flutter_lovers/common_widget/social_login_button.dart';
import 'package:flutter_lovers/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  TextEditingController _controllerUserName;

  @override
  void initState() {
    super.initState();
    _controllerUserName = TextEditingController();
  }

  @override
  void dispose() {
    _controllerUserName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    _controllerUserName.text = _userModel.kullanici.userName;
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.red,
                  backgroundImage: NetworkImage(_userModel.kullanici.profilURL),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _userModel.kullanici.email,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Emailiniz",
                    hintText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controllerUserName,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Kullanıcı Adınız",
                    hintText: "Kullanıcı Adı",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SocialLoginButton(
                  butonText: "Değişiklikleri Kaydet",
                  onPressed: () {
                    _userNameGuncelle(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _cikisYap(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    bool sonuc = await _userModel.signOut();
    Navigator.of(context).pop();
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

  void _userNameGuncelle(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    if (_userModel.kullanici.userName != _controllerUserName.text) {
      var updateResult = await _userModel.updateUserName(
          _userModel.kullanici.kullaniciID, _controllerUserName.text);

      if (updateResult == true) {
        _userModel.kullanici.userName = _controllerUserName.text;
        PlatformDuyarliAlertDialog(
          baslik: "Başarılı",
          icerik: "Kullanıcı Adı Değiştirildi",
          anaButonYazisi: "Tamam",
        ).goster(context);
      } else {
        _controllerUserName.text = _userModel.kullanici.userName;
        PlatformDuyarliAlertDialog(
          baslik: "Hata",
          icerik: "Kullanıcı Zaten Kullanımda",
          anaButonYazisi: "Tamam",
        ).goster(context);
      }
    } else {
      PlatformDuyarliAlertDialog(
        baslik: "Hata",
        icerik: "Kullanıcı Adı Değişikliği Yapmadınız",
        anaButonYazisi: "Tamam",
      ).goster(context);
    }
  }
}
