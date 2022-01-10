import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_manger/globleVariables.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

        // check if authorized or unauthorized
        _firestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .get()
            .then((doc) {
          var data = doc.data()!;
          if (data['isRequestAccepted'] == 'accepted') {
            _appState = AppState.authenticated;
            isCurrentUserAdmin = data['isAdmin'];
            print("isAdmin $isCurrentUserAdmin");
            notifyListeners();
          } else {
            _appState = AppState.unauthorised;
            notifyListeners();
          }
        });

        _appState = AppState.unauthorised;
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

  Future<dynamic> continueWithGoogle() async {
    print("google signin");
    _appState = AppState.authenticating;

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      print("google login in process");
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await _auth.signInWithCredential(authCredential);
      User? user = result.user;

      if (user != null) {
        print("google login in success");

        _appState = AppState.unauthorised;

        String? name = user.displayName;
        String? email = user.email;
        String uuid = user.uid;

        var docRef = _firestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid);

        var getDoc = await docRef.get();
        // if doc already exist (user already added in firestore), don't overwrite data
        // only write data if user is first time signing up
        if (!getDoc.exists)
          await docRef.set({
            'name': name,
            'email': email,
            'uuid': uuid,
            'joinDate': Timestamp.now().millisecondsSinceEpoch,
            'isRequestAccepted': 'pending', // pending, accepted, rejected
            'isAdmin': false,
          });

        notifyListeners();
      } else
        print("google login failed");
    }
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
  }) async {
    _firestore.collection('users').doc(_firebaseAuth.currentUser!.uid).update({
      'name': name,
    });
  }
}
