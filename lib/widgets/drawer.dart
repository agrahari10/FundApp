import 'package:flutter/material.dart';
import 'package:fund_manger/Page/adminPage.dart';
import 'package:fund_manger/Page/members.dart';
import 'package:fund_manger/globleVariables.dart';
import 'package:fund_manger/repository/authRepository.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Center(
            child: Container(
              child: Text(
                'image comming soon',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Home"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text("Transaction History"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text("Memebers"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Members()));
            },
          ),
          if (isCurrentUserAdmin)
            ListTile(
              leading: Icon(Icons.admin_panel_settings),
              title: Text("Admin Page"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminPage()));
              },
            ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              AuthRepository().logout();
            },
          ),
        ],
      ),
    );
  }
}
