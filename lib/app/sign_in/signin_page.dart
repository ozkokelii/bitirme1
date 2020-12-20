import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lovers/app/sign_in/email_sifre_giris_ve_kayit.dart';
import 'package:flutter_lovers/common_widget/social_login_button.dart';
import 'package:flutter_lovers/model/user.dart';
import 'package:flutter_lovers/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

class SigninPage extends StatelessWidget {
  /*void _misafirGiris(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    Kullanici _kullanici = await _userModel.signInAnonymously();
    print("oturum açma user id : " + _kullanici.kullaniciID.toString());
  }*/

  void _facebookIleGiris(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    Kullanici _kullanici = await _userModel.signInWithFacebook();
    if (_kullanici != null)
      print("oturum açma user id : " + _kullanici.kullaniciID.toString());
  }

  void _googleIleGiris(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    Kullanici _kullanici = await _userModel.signInWithGoogle();
    if (_kullanici != null)
      print("oturum açma user id : " + _kullanici.kullaniciID.toString());
  }

  void _emailVeSifreGiris(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => EmailVeSifreLoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Canli Sohbet"),
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              "Oturum Açın",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            SizedBox(
              height: 8,
            ),
            SocialLoginButton(
              butonText: "Gmail ile Giriş Yap",
              butonColor: Colors.white,
              textColor: Colors.black87,
              onPressed: () => _googleIleGiris(context),
              butonIcon: Image.asset("images/google-logo.png"),
            ),
            SocialLoginButton(
              butonColor: Color(0xFF334D92),
              butonText: "Facebook ile Giriş",
              onPressed: () => _facebookIleGiris(context),
              butonIcon: Image.asset("images/facebook-logo.png"),
            ),
            SocialLoginButton(
              onPressed: () => _emailVeSifreGiris(context),
              butonText: "Email ve Şifre ile Giriş Yap",
              butonIcon: Icon(
                Icons.email,
                size: 32,
                color: Colors.white,
              ),
            ),
            /*SocialLoginButton(
              butonText: "Misafir Olarak Giriş Yap",
              onPressed: () => _misafirGiris(context),
              butonIcon: Icon(Icons.supervised_user_circle),
              butonColor: Colors.teal,
            ),*/
          ],
        ),
      ),
    );
  }
}
