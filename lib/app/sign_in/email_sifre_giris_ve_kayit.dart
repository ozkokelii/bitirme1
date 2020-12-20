import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lovers/app/hata_exception.dart';
import 'package:flutter_lovers/common_widget/platform_duyarli_alert_dialog.dart';
import 'package:flutter_lovers/common_widget/social_login_button.dart';
import 'package:flutter_lovers/model/user.dart';
import 'package:flutter_lovers/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

enum FormType { Register, Login }

class EmailVeSifreLoginPage extends StatefulWidget {
  @override
  _EmailVeSifreLoginPageState createState() => _EmailVeSifreLoginPageState();
}

class _EmailVeSifreLoginPageState extends State<EmailVeSifreLoginPage> {
  String _email, _sifre;
  String _buttonText, _linkText;
  var _formType = FormType.Login;
  final _formKey = GlobalKey<FormState>();

  void _formSubmit() async {
    _formKey.currentState.save();
    debugPrint("email : " + _email + "sifre : " + _sifre);
    final _userModel = Provider.of<UserModel>(context, listen: false);
    if (_formType == FormType.Login) {
      try {
        Kullanici _girisYapanUser =
            await _userModel.signInWithEmailAndPassword(_email, _sifre);
        if (_girisYapanUser != null)
          print("oturum açma user id : " +
              _girisYapanUser.kullaniciID.toString());
      } on FirebaseAuthException catch (e) {
        PlatformDuyarliAlertDialog(
          baslik: "Oturum açma HATA",
          icerik: Hatalar.goster(e.code),
          anaButonYazisi: 'Tamam',
        ).goster(context);
      }
    } else {
      try {
        Kullanici _olusturulanUser =
            await _userModel.createUserWithEmailAndPassword(_email, _sifre);
        if (_olusturulanUser != null)
          print("oturum açma user id : " +
              _olusturulanUser.kullaniciID.toString());
      } on FirebaseAuthException catch (e) {
        PlatformDuyarliAlertDialog(
          baslik: "Kullanıcı Oluşturma HATA",
          icerik: Hatalar.goster(e.code),
          anaButonYazisi: 'Tamam',
        ).goster(context);
      }
    }
  }

  void _degistir() {
    setState(() {
      _formType =
          _formType == FormType.Login ? FormType.Register : FormType.Login;
    });
  }

  @override
  Widget build(BuildContext context) {
    _buttonText = _formType == FormType.Login ? "Giriş Yap" : "Kayıt Ol";
    _linkText = _formType == FormType.Login
        ? "Hesabınız Yoksa Kayıt OLun "
        : "Hesabınız Varsa Giriş Yapın";

    final _userModel = Provider.of<UserModel>(context, listen: false);

    if (_userModel.kullanici != null) {
      Future.delayed(Duration(milliseconds: 10), () {
        Navigator.of(context).pop();
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Giris Kayıt"),
        ),
        body: _userModel.state == ViewState.Idle
            ? SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            errorText: _userModel.emailHataMesaji != null
                                ? _userModel.emailHataMesaji
                                : null,
                            hintText: "Email",
                            labelText: "Email",
                            prefixIcon: Icon(Icons.mail),
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (String girilenEmail) {
                            _email = girilenEmail;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            errorText: _userModel.sifreHataMesaji != null
                                ? _userModel.sifreHataMesaji
                                : null,
                            hintText: "Password",
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock_outline),
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (String girilenSifre) {
                            _sifre = girilenSifre;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SocialLoginButton(
                          butonText: _buttonText,
                          butonColor: Theme.of(context).primaryColor,
                          radius: 10,
                          onPressed: () => _formSubmit(),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FlatButton(
                            onPressed: () => _degistir(),
                            child: Text(_linkText))
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
