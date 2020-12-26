import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_lovers/model/mesaj.dart';
import 'package:flutter_lovers/model/user.dart';
import 'package:flutter_lovers/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

class Konusma extends StatefulWidget {
  final Kullanici currentUser;
  final Kullanici sohbetEdilenUser;

  Konusma({this.currentUser, this.sohbetEdilenUser});

  @override
  _KonusmaState createState() => _KonusmaState();
}

class _KonusmaState extends State<Konusma> {
  var _mesajController = TextEditingController();
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    Kullanici _currentUser = widget.currentUser;
    Kullanici _sohbetEdilenUser = widget.sohbetEdilenUser;
    final _userModel = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sohbet"),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Mesaj>>(
                stream: _userModel.getMessages(
                    _currentUser.kullaniciID, _sohbetEdilenUser.kullaniciID),
                builder: (context, streamMesajlarListesi) {
                  if (!streamMesajlarListesi.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<Mesaj> tumMesajlar = streamMesajlarListesi.data;
                  return ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      return _konusmaBalonuOlustur(tumMesajlar[index]);
                    },
                    itemCount: tumMesajlar.length,
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 8, left: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _mesajController,
                      cursorColor: Colors.blueGrey,
                      style: new TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Mesajınız Yazın",
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.navigation,
                        size: 35,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        if (_mesajController.text.trim().length > 0) {
                          Mesaj _kaydedilecekMesaj = Mesaj(
                            kimden: _currentUser.kullaniciID,
                            kime: _sohbetEdilenUser.kullaniciID,
                            bendenMi: true,
                            mesaj: _mesajController.text,
                          );
                          var sonuc =
                              await _userModel.saveMessage(_kaydedilecekMesaj);
                          if (sonuc) {
                            _mesajController.clear();
                            _scrollController.animateTo(0.0,
                                duration: const Duration(milliseconds: 10),
                                curve: Curves.easeOut);
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _konusmaBalonuOlustur(Mesaj oankiMesaj) {
    Color _gelenMesajRenk = Colors.blue;
    Color _gidenMesajRenk = Colors.orange;

    var _benimMesajimMi = oankiMesaj.bendenMi;
    if (_benimMesajimMi) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: _gidenMesajRenk,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(4),
              child: Text(
                oankiMesaj.mesaj,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage(widget.sohbetEdilenUser.profilURL),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: _gelenMesajRenk,
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(4),
                child: Text(oankiMesaj.mesaj),
              ),
            ],
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      );
    }
  }
}