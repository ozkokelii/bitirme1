import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lovers/tab_items.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    Key key,
    @required this.currentTab,
    @required this.onselectedTab,
    @required this.sayfaOlusturucu,
    @required this.navigatorKeys,
  }) : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onselectedTab;
  final Map<TabItem, Widget> sayfaOlusturucu;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            _navItemOlustur(TabItem.Kullanicilar),
            _navItemOlustur(TabItem.Profil),
          ],
          onTap: (index) => onselectedTab(TabItem.values[index]),
        ),
        tabBuilder: (context, index) {
          final gosterilecekItem = TabItem.values[index];
          return CupertinoTabView(
            navigatorKey: navigatorKeys[gosterilecekItem],
            builder: (context) {
              return sayfaOlusturucu[gosterilecekItem];
            },
          );
        });
  }

  BottomNavigationBarItem _navItemOlustur(TabItem tabItem) {
    final olusturulacakTab = TabItemData.tumTablar[tabItem];

    // ignore: deprecated_member_use
    return BottomNavigationBarItem(
      icon: Icon(olusturulacakTab.icon),
      title: Text(olusturulacakTab.title),
    );
  }
}
