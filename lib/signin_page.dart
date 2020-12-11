import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lovers/common_widget/social_login_button.dart';

class SigninPage extends StatelessWidget {
  final Function(User) onSignIn;

  const SigninPage({Key key, @required this.onSignIn}) : super(key: key);

  void _misafirGiris() async {
    UserCredential sonuc = await FirebaseAuth.instance.signInAnonymously();
    onSignIn(sonuc.user);
    print("oturum açma user id : " + sonuc.user.uid.toString());
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
              onPressed: () {},
              butonIcon: Image.asset("images/google-logo.png"),
            ),
            SocialLoginButton(
              butonColor: Color(0xFF334D92),
              butonText: "Facebook ile Giriş",
              onPressed: () {},
              butonIcon: Image.asset("images/facebook-logo.png"),
            ),
            SocialLoginButton(
              onPressed: () {},
              butonText: "Email ve Şifre ile Giriş Yap",
              butonIcon: Icon(
                Icons.email,
                size: 32,
                color: Colors.white,
              ),
            ),
            SocialLoginButton(
              butonText: "Misafir Olarak Giriş Yap",
              onPressed: _misafirGiris,
              butonIcon: Icon(Icons.supervised_user_circle),
              butonColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
