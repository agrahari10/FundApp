import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';

class UnauthorizedPage extends StatelessWidget {
  const UnauthorizedPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Homescreen(
          name1:
              'Account successfully created, waiting for authorization. Contact admin.',
          size: size * 1.1,
          name: 'Fund Manager',
          icon: FaIcon(FontAwesomeIcons.checkCircle),
          onPressed: () {},
        ),
      ),
    );
  }
}
