import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fund_manger/Page/funds.dart';
import 'package:fund_manger/Page/screen.dart';
import 'package:fund_manger/repository/authRepository.dart';
import 'package:fund_manger/repository/dbRepository.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(
    MultiProvider(
      child: MyApp(),
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthRepository(),
        ),
        ChangeNotifierProvider(
          create: (_) => DbRepository(),
        ),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(child: _showScreen(context)));
  }
}

Widget _showScreen(BuildContext context) {
  switch (context.watch<AuthRepository>().appState) {
    case AppState.initial:
    case AppState.unauthenticated:
    case AppState.authenticating:
      return Home();
    case AppState.unauthorised:
      return UnauthorizedPage();
    case AppState.authenticated:
      return FundAvailable();
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          // child: FundAvailable(),
          child: Homescreen(
            size: size,
            name: 'Fund Manager',
            icon: FaIcon(FontAwesomeIcons.google), // login to enter in fundApp
            name1: 'Continue with google',
            onPressed: () async {
              await AuthRepository().continueWithGoogle();
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => Screen()));
            },
          ),
        ),
      ),
    );
  }
}

class Homescreen extends StatelessWidget {
  Homescreen({
    Key? key,
    required this.size,
    required this.name,
    required this.name1,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final Size size;
  String name;
  String name1;
  FaIcon icon;
  final Function onPressed; // onpresed to navigate on other page

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [Color(0xFFF12711), Color(0xFFF5AF19)])),
      // color: Color(0xFF12711),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(
              top: size.width * 0.65,
              left: size.width * 0.01,
              right: size.width * 0.01),
          child: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                    fontSize: size.width * 0.1,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffFFFFFF)),
              ),
              Card(
                color: Color(0xFF37373799),
                margin: EdgeInsets.only(
                    top: size.width * 0.1,
                    bottom: size.width * 0.2,
                    left: size.width * 0.02,
                    right: size.width * 0.02),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      onPressed(); //
                    },
                    child: Padding(
                      padding: EdgeInsets.all(size.width * 0.03),
                      child: Column(
                        children: [
                          icon,
                          Text(
                            name1,
                            style: TextStyle(color: Colors.white),
                          ), // name in gesturDectector
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
