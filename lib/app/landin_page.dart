import 'package:flutter/material.dart';
import 'package:flutter_lovers/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

import 'file:///C:/flutter_projects/flutter_lovers/lib/app/home_page.dart';
import 'file:///C:/flutter_projects/flutter_lovers/lib/app/sign_in/signin_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context);
    if (_userModel.state == ViewState.Idle) {
      if (_userModel.kullanici == null) {
        return SigninPage();
      } else {
        return HomePage(kullanici: _userModel.kullanici);
      }
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
