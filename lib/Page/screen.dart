import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';


class Screen  extends StatelessWidget {
  const Screen ({ Key? key }) : super(key: key);
  static const routeName2 = '/Screen';


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Homescreen(
        size: size,
        name: 'Account successfully created, waiting for authorization. Contact admin.',
        icon: FaIcon(FontAwesomeIcons.checkCircle),
      ),
    );
  }
}