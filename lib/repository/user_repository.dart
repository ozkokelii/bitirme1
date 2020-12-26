import 'dart:async';
import 'dart:core';

import 'package:flutter_lovers/locator.dart';
import 'package:flutter_lovers/model/user.dart';
import 'package:flutter_lovers/services/auth_base.dart';
import 'package:flutter_lovers/services/fake_auth_service.dart';
import 'package:flutter_lovers/services/firebase_auth_service.dart';
import 'package:flutter_lovers/services/firebase_storage_service.dart';
import 'package:flutter_lovers/services/firestore_db_service.dart';
import 'package:flutter_lovers/model/mesaj.dart';

enum AppMode { DEBUG, RELEASE }

class UserRepository implements AuthBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FakeAuthService _fakeAuthService = locator<FakeAuthService>();
  FirestoreDBService _fireStoreDBService = locator<FirestoreDBService>();
  FirebaseStorageService _firebaseStorageService =
      locator<FirebaseStorageService>();

  AppMode appMode = AppMode.RELEASE;

  @override
  Future<Kullanici> currentUser() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.currentUser();
    } else {
      Kullanici _kullanici = await _firebaseAuthService.currentUser();
      return await _fireStoreDBService.readUser(_kullanici.kullaniciID);
    }
  }

  @override
  Future<Kullanici> signInAnonymously() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signInAnonymously();
    } else {
      return await _firebaseAuthService.signInAnonymously();
    }
  }

  @override
  Future<bool> signOut() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signOut();
    } else {
      return await _firebaseAuthService.signOut();
    }
  }

  @override
  Future<Kullanici> signInWithGoogle() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signInWithGoogle();
    } else {
      Kullanici _kullanici = await _firebaseAuthService.signInWithGoogle();
      bool _sonuc = await _fireStoreDBService.saveUser(_kullanici);
      if (_sonuc) {
        return await _fireStoreDBService.readUser(_kullanici.kullaniciID);
      } else
        return null;
    }
  }

  @override
  Future<Kullanici> signInWithFacebook() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signInWithFacebook();
    } else {
      Kullanici _kullanici = await _firebaseAuthService.signInWithFacebook();
      bool _sonuc = await _fireStoreDBService.saveUser(_kullanici);
      if (_sonuc) {
        return await _fireStoreDBService.readUser(_kullanici.kullaniciID);
      } else
        return null;
    }
  }

  @override
  Future<Kullanici> createUserWithEmailAndPassword(
      String email, String sifre) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.createUserWithEmailAndPassword(
          email, sifre);
    } else {
      Kullanici _kullanici = await _firebaseAuthService
          .createUserWithEmailAndPassword(email, sifre);
      bool _sonuc = await _fireStoreDBService.saveUser(_kullanici);
      if (_sonuc) {
        return await _fireStoreDBService.readUser(_kullanici.kullaniciID);
      } else
        return null;
    }
  }

  @override
  Future<Kullanici> signInWithEmailAndPassword(
      String email, String sifre) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signInWithEmailAndPassword(email, sifre);
    } else {
      Kullanici _kullanici =
          await _firebaseAuthService.signInWithEmailAndPassword(email, sifre);

      return await _fireStoreDBService.readUser(_kullanici.kullaniciID);
    }
  }

  Future<bool> updateUserName(String kullaniciID, String yeniUserName) async {
    if (appMode == AppMode.DEBUG) {
      return false;
    } else {
      return await _fireStoreDBService.updateUserName(
          kullaniciID, yeniUserName);
    }
  }

  Future<String> uploadFile(
      String kullaniciID, String fileType, profilFoto) async {
    if (appMode == AppMode.DEBUG) {
      return "dosya indirme linki";
    } else {
      var porfilFotoURL = await _firebaseStorageService.uploadFile(
          kullaniciID, fileType, profilFoto);
      await _fireStoreDBService.updateProfilFoto(kullaniciID, porfilFotoURL);
      return porfilFotoURL;
    }
  }

  Future<List<Kullanici>> getAllUser() async {
    if (appMode == AppMode.DEBUG) {
      return [];
    } else {
      var tumKullaniciListesi = await _fireStoreDBService.getAllUsers();
      return tumKullaniciListesi;
    }
  }

  Stream<List<Mesaj>> getMessages(String currentUserID, String sohbetEdilenUserID) {
    if (appMode == AppMode.DEBUG) {
      return Stream.empty();
    } else {
      return _fireStoreDBService.getMessages(currentUserID, sohbetEdilenUserID);
    }
  }

  Future<bool> saveMessage(Mesaj kaydedilecekMesaj) async{
    if (appMode == AppMode.DEBUG) {
      return true;
    } else {
      return _fireStoreDBService.saveMessage(kaydedilecekMesaj);
    }

  }
}
