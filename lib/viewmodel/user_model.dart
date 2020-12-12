import 'package:flutter/material.dart';
import 'package:flutter_lovers/locator.dart';
import 'package:flutter_lovers/model/user_model.dart';
import 'package:flutter_lovers/repository/user_repository.dart';
import 'package:flutter_lovers/services/auth_base.dart';

enum ViewState { Idle, Busy }

class UserModel with ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.Idle;
  UserRepository _userRepository = locator<UserRepository>();
  Kullanici _kullanici;

  Kullanici get kullanici => _kullanici;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel() {
    currentUser();
  }

  @override
  Future<Kullanici> currentUser() async {
    try {
      state = ViewState.Busy;
      _kullanici = await _userRepository.currentUser();
      return _kullanici;
    } catch (e) {
      debugPrint("viewmodeldeki current user hatası " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<Kullanici> signInAnonymously() async {
    try {
      state = ViewState.Busy;
      _kullanici = await _userRepository.signInAnonymously();
      return _kullanici;
    } catch (e) {
      debugPrint("viewmodeldeki current user hatası " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _kullanici = null;
      return sonuc;
    } catch (e) {
      debugPrint("viewmodeldeki current user hatası " + e.toString());
      return false;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<Kullanici> signInWithGoogle() async {
    try {
      state = ViewState.Busy;
      _kullanici = await _userRepository.signInWithGoogle();
      return _kullanici;
    } catch (e) {
      debugPrint("viewmodeldeki current user hatası " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<Kullanici> signInWithFacebook() async {
    try {
      state = ViewState.Busy;
      _kullanici = await _userRepository.signInWithFacebook();
      return _kullanici;
    } catch (e) {
      debugPrint("viewmodeldeki current user hatası " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<Kullanici> createUserWithEmailAndPassword(
      String email, String sifre) async {
    try {
      state = ViewState.Busy;
      _kullanici =
          await _userRepository.createUserWithEmailAndPassword(email, sifre);
      return _kullanici;
    } catch (e) {
      debugPrint("viewmodeldeki current user hatası " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<Kullanici> signInWithEmailAndPassword(
      String email, String sifre) async {
    try {
      state = ViewState.Busy;
      _kullanici =
          await _userRepository.signInWithEmailAndPassword(email, sifre);
      return _kullanici;
    } catch (e) {
      debugPrint("viewmodeldeki current user hatası " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }
}
