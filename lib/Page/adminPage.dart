import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fund_manger/repository/dbRepository.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  Future _showDialog(BuildContext context, String fundHistoryUid) {
    DbRepository _dbRepo = DbRepository();
    return showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          content: Text('Verify fund payment?'),
          actions: [
            TextButton(
              onPressed: () {
                _dbRepo
                    .verifyFundAddPayment(fundHistoryUid: fundHistoryUid)
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Payment verified'),
                    ),
                  );
                  Navigator.of(context).pop(dialogContext);
                });
              },
              child: Text('Verify'),
            ),
            TextButton(
              onPressed: () {
                _dbRepo
                    .rejectFundAddPaymentVerification(
                        fundHistoryUid: fundHistoryUid)
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Payment rejected'),
                    ),
                  );

                  Navigator.of(context).pop(dialogContext);
                });
              },
              child: Text('Reject'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(dialogContext);
                },
                child: Text('Close Dialog')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _firestore = FirebaseFirestore.instance;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [Color(0xFFF12711), Color(0xFFF12711)],
            ),
          ),

          //
          child: Column(
            children: [
              Icon(
                Icons.admin_panel_settings,
                size: 80,
                color: Colors.white,
              ),

              // verify add fund
              StreamBuilder(
                stream: _firestore
                    .collection("fundAddHistory")
                    .where("status", isEqualTo: "pending")
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return CircularProgressIndicator();
                  else {
                    var data = snapshot.data;
                    data.docs.forEach((doc) => {
                          print(doc.data()['amount']),
                        });

                    return SizedBox(
                      height: size.height * 0.7,
                      child: ListView.builder(
                        itemCount: data.docs.length,
                        itemBuilder: (context, index) {
                          var docData = data.docs[index].data();
                          return ListTile(
                            style: ListTileStyle.list,
                            trailing: GestureDetector(
                              onTap: () {
                                _showDialog(context, docData['fundHistoryUid']);
                              },
                              child: Icon(
                                Icons.arrow_drop_down_circle_outlined,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              'Rs ${docData['amount']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              docData['name'],
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
