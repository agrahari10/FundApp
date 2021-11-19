import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fund_manger/widgets/Reusable.dart';
import 'package:fund_manger/widgets/style.dart';

class FundAvailable extends StatefulWidget {
  const FundAvailable({Key? key}) : super(key: key);

  @override
  _FundAvailableState createState() => _FundAvailableState();
}

class _FundAvailableState extends State<FundAvailable> {
  double balance = 1250;
  String item = 'Sabzi';
  int amount = 100;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFF12711), Color(0xFFF5AF19)])),
            child: Column(
              children: [
                ListTile(
                  leading: Builder(
                    builder: (context) => IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: Icon(Icons.menu),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(size.width * 0.05),
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          'Available Funds',
                          style: cardItemTextStyle.copyWith(
                            fontSize: size.width * 0.07,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                      Container(
                        child: Text('Rs.$balance',
                            style: cardItemTextStyle.copyWith(
                              fontSize: size.width * 0.1,
                              color: Color(0xffFFFFFF),
                            )),
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          children: [
                            for (int i = 0; i <= 10; i++)
                              Reusablecard(
                                  item: item, size: size, amount: amount),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          icon: Icon(
            Icons.add,
            color: Colors.black,
          ),
          label: Text(
            'Add record',
            style: cardItemTextStyle.copyWith(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        drawer: Drawer(
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
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}


