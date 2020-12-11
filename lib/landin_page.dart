import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lovers/home_page.dart';
import 'package:flutter_lovers/signin_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPagexState createState() => _LandingPagexState();
}

class _LandingPagexState extends State<LandingPage> {
  User _kullanici;

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  @override
  Widget build(BuildContext context) {
    if (_kullanici == null) {
      return SigninPage(
        onSignIn: (kullanici) {
          _updateUser(kullanici);
        },
      );
    } else {
      return HomePage(
        kullanici: _kullanici,
        onSignOut: () {
          _updateUser(null);
        },
      );
    }
  }

  Future<void> _checkUser() async {
    _kullanici = FirebaseAuth.instance.currentUser;
  }

  // ignore: deprecated_member_use
  void _updateUser(User kullanici) {
    setState(() {
      _kullanici = kullanici;
    });
  }
}
