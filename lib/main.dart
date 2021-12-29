import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fund_manger/Page/Cardoverview.dart';
import 'package:fund_manger/Page/Record.dart';
import 'package:fund_manger/Page/addfund.dart';
import 'package:fund_manger/Page/funds.dart';
import 'package:fund_manger/Page/memberOverview.dart';
import 'package:fund_manger/Page/members.dart';
import 'package:fund_manger/Page/paymentoverview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: PaymentOverview());
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
          child: FundAvailable(),
          // child: Homescreen(
          //   size: size,
          //   name: 'Continue with google',
          //   icon: FaIcon(FontAwesomeIcons.google),
          // ),
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
    required this.icon,
  }) : super(key: key);

  final Size size;
  String name;
  FaIcon icon;

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
          padding: EdgeInsets.only(top: size.width * 0.5),
          child: Column(
            children: [
              Text(
                'Fund Manager',
                style: TextStyle(
                    fontSize: size.width * 0.1,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffFFFFFF)),
              ),
              Card(
                color: Color(0xFF37373799),
                margin: EdgeInsets.only(
                    top: size.width * 0.2,
                    bottom: size.width * 0.2,
                    left: size.width * 0.05,
                    right: size.width * 0.05),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      print('ccc' * 100);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(size.width * 0.03),
                      child: Column(
                        children: [
                          icon,
                          Text(name),
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
