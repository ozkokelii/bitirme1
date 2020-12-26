import 'package:flutter/material.dart';
import 'package:flutter_lovers/app/konusma.dart';
import 'package:flutter_lovers/model/user.dart';
import 'package:flutter_lovers/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

class Kullanicilar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Kullanıcılar"),
        ),
        body: FutureBuilder<List<Kullanici>>(
          future: _userModel.getAllUser(),
          builder: (context, sonuc) {
            if (sonuc.hasData) {
              var tumKullanicilar = sonuc.data;
              if (tumKullanicilar.length - 1 > 0) {
                return ListView.builder(
                  itemCount: tumKullanicilar.length,
                  itemBuilder: (context, index) {
                    var oAnkiUser = sonuc.data[index];
                    if (oAnkiUser.kullaniciID !=
                        _userModel.kullanici.kullaniciID) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (context) => Konusma(
                                currentUser: _userModel.kullanici,
                                sohbetEdilenUser: oAnkiUser,
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(oAnkiUser.userName),
                          subtitle: Text(oAnkiUser.email),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(oAnkiUser.profilURL),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              } else {}
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
