import 'package:flutter/material.dart';
import 'package:flutter_lovers/app/bottom_nav.dart';
import 'package:flutter_lovers/app/kullanicilar.dart';
import 'package:flutter_lovers/app/profil.dart';
import 'package:flutter_lovers/model/user.dart';
import 'package:flutter_lovers/tab_items.dart';

class HomePage extends StatefulWidget {
  final Kullanici kullanici;

  HomePage({Key key, @required this.kullanici}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.Kullanicilar;
  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.Kullanicilar: GlobalKey<NavigatorState>(),
    TabItem.Profil: GlobalKey<NavigatorState>(),
  };
  Map<TabItem, Widget> tumSayfalar() {
    return {
      TabItem.Kullanicilar: Kullanicilar(),
      TabItem.Profil: Profil(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: BottomNav(
        sayfaOlusturucu: tumSayfalar(),
        navigatorKeys: navigatorKeys,
        currentTab: _currentTab,
        onselectedTab: (secilenTab) {
          if (secilenTab == _currentTab) {
            navigatorKeys[secilenTab]
                .currentState
                .popUntil((route) => route.isFirst);
          } else {
            setState(() {
              _currentTab = secilenTab;
            });
          }
        },
      ),
    );
  }
}
/*
Future<bool> _cikisYap(BuildContext context) async {
  final _userModel = Provider.of<UserModel>(context, listen: false);
  bool sonuc = await _userModel.signOut();
  return sonuc;
}
 */
