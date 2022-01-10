import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fund_manger/Page/Record.dart';
import 'package:fund_manger/Page/addfund.dart';
import 'package:fund_manger/Page/members.dart';
import 'package:fund_manger/repository/authRepository.dart';
import 'package:fund_manger/repository/dbRepository.dart';
import 'package:fund_manger/widgets/Reusable.dart';
import 'package:fund_manger/widgets/drawer.dart';
import 'package:fund_manger/widgets/style.dart';

import 'Cardoverview.dart';

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
        appBar: AppBar(
          elevation: 0,
          flexibleSpace: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFF12711), Color(0xFFF12711)]))),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFF12711), Color(0xFFF5AF19)])),
            child: Column(
              children: [
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
                        child: StreamBuilder(
                          initialData: 0,
                          stream: DbRepository().getAvailableFundStream(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState !=
                                    ConnectionState.active ||
                                snapshot.error != null ||
                                snapshot.data == null ||
                                !snapshot.hasData)
                              return CircularProgressIndicator();
                            else {
                              var data = snapshot.data.docs[0];

                              print("* " * 20);
                              print(data);
                              return Text('Rs. ${data['totalFundAmount']}',
                                  style: cardItemTextStyle.copyWith(
                                    fontSize: size.width * 0.1,
                                    color: Color(0xffFFFFFF),
                                  ));
                            }
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          children: [
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("transactions")
                                  .orderBy("timestamp", descending: true)
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.data == null)
                                  return CircularProgressIndicator();

                                return SizedBox(
                                  height: size.height * 0.7,
                                  child: ListView.builder(
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, index) {
                                      var data = snapshot.data.docs[index];
                                      return Reusablecard(
                                        item: data['itemName'],
                                        size: size,
                                        amount: data['amount'],
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => CardView(
                                                amount: data['amount'],
                                                comment: data['comment'],
                                                consumersList:
                                                    data['consumersUids'],
                                                consumerNames:
                                                    data['consumerNames'],
                                                dateTime: DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        data['timestamp']),
                                                item: data['itemName'],
                                                recordedBy: data['recordedBy'],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
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
          onPressed: () async {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Record(),
            ));
          },
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
        drawer: AppDrawer(),
      ),
    );
  }
}
