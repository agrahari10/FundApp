import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AppState {
  initial,
  authenticated,
  authenticating,
  unauthenticated,
  unauthorised,
}

class AuthRepository with ChangeNotifier {
  final FirebaseAuth _auth;
  // ignore: prefer_typing_uninitialized_variables
  var _user;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // final GoogleSignIn _googleSignIn;
  AppState _appState = AppState.initial;

  AppState get appState => _appState;
  get user => _user;

  AuthRepository() : _auth = FirebaseAuth.instance {
    print('*' * 100);
    print('user repository initialised');
    print('*' * 100);
    // _appState = AppState.unauthenticated;

    _auth.authStateChanges().listen((firebaseUser) async {
      if (firebaseUser == null) {
        _appState = AppState.unauthenticated;
        notifyListeners();
      } else {
        print('logged In');
        _user = firebaseUser;

        _appState = AppState.authenticated;
        notifyListeners();

        // print('*' * 200);
        // print(data);
        // print('*' * 200);
      }
    });
  }

  Future<dynamic> login(String email, String password) async {
    // try {
    // _appState = AppState.authenticating; //set current state to loading state.
    // notifyListeners();

    var user = await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((error) {
      print(error.code);
      _appState = AppState.unauthenticated;
      notifyListeners();

      throw error;
    });

    _appState = AppState.authenticated;
    notifyListeners();
    return user;
    // }
    //  catch (e) {
    //   print(e.toString() + '*******');
    //   _appState = AppState.unauthenticated;
    //   notifyListeners();
    //   throw e;
    // }
  }

  Future<dynamic> signup({
    required String email,
    required String password,
    required String phoneNumber,
    required String name,
  }) async {
    _appState = AppState.authenticating;
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    _appState = AppState.unauthorised;

    await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'name': name,
      'email': email,
      'uuid': FirebaseAuth.instance.currentUser!.uid,
      'joinDate': Timestamp.now(),
      'isRequestAccepted': 'pending', // pending, accepted, rejected
      'isAdmin': false,
    }).then((value) {
      _appState = AppState.authenticated;
      notifyListeners();
    }).catchError((error) {
      _appState = AppState.unauthenticated;
      notifyListeners();
      throw error;
    });
  }

  Future logout() async {
    await _auth.signOut();

    _appState = AppState.unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<dynamic> getCurrentUserDetails() async {
    var _user = _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .get();
    return _user;
  }

  Future<void> updateUserProfile({
    required String name,
    required String phoneNumber,
    required String address,
  }) async {
    _firestore.collection('users').doc(_firebaseAuth.currentUser!.uid).update({
      'name': name,
      'address': address,
    });
  }
}
