import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fund_manger/Page/addfund.dart';
import 'package:fund_manger/Page/funds.dart';

import '../main.dart';


class Screen  extends StatelessWidget {
  const Screen ({ Key? key }) : super(key: key);
  static const routeName2 = '/Screen';


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Homescreen(
          name1:'Account successfully created, waiting for authorization. Contact admin.', 
          size: size*1.1,
          name: 'Fund Manager',
          icon: FaIcon(FontAwesomeIcons.checkCircle),
          onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => FundAvailable()));

          },
          ),
      ),
      );
    
  }
}