import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_manger/models/userModel.dart';
import 'package:fund_manger/repository/dbRepository.dart';
import 'package:fund_manger/widgets/style.dart';

class Record extends StatefulWidget {
  const Record({Key? key}) : super(key: key);

  @override
  _RecordState createState() => _RecordState();
}

class _RecordState extends State<Record> {
  List<Map> selectedList = []; // users consumers
  List<Map> allUsers = []; // Map List {"name": name, "uuid": uuid}

  String itemName = "";
  double amount = 0;
  String comment = "";

  bool isDataLoaded = false;

  late UserModel currentUser;

  String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  final DbRepository _dbRepository = DbRepository();

  @override
  Widget build(BuildContext context) {
    if (!isDataLoaded) {
      // DbRepository().getAuthorizedUsersIds().then((uids) {
      //   print(uids);
      //   uids.forEach((uid) {
      //     DbRepository().getUserDetails(uuid: uid).then((data) {
      //       print(data.name);
      //       if (mounted)
      //         setState(() {
      //           allUsers.add({"name": data.name, "uuid": data.uuid});
      //         });
      //     });
      //   });
      // });

      _dbRepository.getAuthorizedUsers().then((users) {
        for (UserModel user in users) {
          if (mounted)
            setState(() {
              allUsers.add({"name": user.name, "uuid": user.uuid});
            });
        }
      });

      if (mounted)
        setState(() {
          DbRepository().getUserDetails(uuid: currentUserId).then((user) {
            currentUser = user;
            isDataLoaded = true;
          });
        });
    }
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
                colors: [Color(0xFFF12711), Color(0xFFF12711)],
              ),
            ),
          ),
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
            child: isDataLoaded
                ? Column(
                    children: [
                      Container(
                        child: Text(
                          'Add Record',
                          style: cardItemTextStyle.copyWith(
                            fontSize: size.width * 0.08,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(size.height * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            TextField(
                              onChanged: (value) {
                                itemName = value;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(size.height * 0.01),
                                ),
                                hintText:
                                    'Item Name', // item name which is brought by user or consumer
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                amount = double.parse(value);
                              },
                              // obscureText: false,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(size.height * 0.01),
                                ),
                                hintText: 'Amount', // amount to be added
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextField(
                              onChanged: (value) {
                                comment = value;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(size.height * 0.01),
                                ),
                                hintText: 'Comment (Optinal)',
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'Consumers',
                              style: cardItemTextStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: size.height * 0.04,
                                  fontWeight: FontWeight.normal),
                            ),
                            Column(
                              children: [
                                for (int i = 0; i < allUsers.length; i++)
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.05,
                                        width: 200,
                                        child: CheckboxListTile(
                                          onChanged: (value) {
                                            if (mounted)
                                              setState(() {
                                                if (selectedList
                                                    .contains(allUsers[i]))
                                                  selectedList
                                                      .remove(allUsers[i]);
                                                else
                                                  selectedList.add(allUsers[i]);

                                                /// users which are going to consume
                                              });
                                            print(selectedList);
                                          },
                                          title: Text(
                                            allUsers[i]['name'],
                                            style: cardItemTextStyle.copyWith(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          value: selectedList
                                              .contains(allUsers[i]),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white, // background
                                  onPrimary: Colors.black, // foreground
                                ),
                                onPressed: () async {
                                  // details added by buyer e.g  consumers,amount,

                                  List<String> consumersUids = [];
                                  selectedList.forEach((user) {
                                    consumersUids.add(user['uuid']);
                                  });

                                  UserModel currentUser = await DbRepository()
                                      .getUserDetails(
                                          uuid: FirebaseAuth
                                              .instance.currentUser!.uid);

                                  DbRepository()
                                      .addRecord(
                                        itemName: itemName,
                                        amount: amount,
                                        recordedByUid: currentUser.uuid,
                                        consumersUids: consumersUids,
                                        comment: comment,
                                        recordedBy: currentUser.name,
                                      )
                                      .then(
                                        (value) => Navigator.of(context).pop(),
                                      );

                                  // .addFund(
                                  //   amount: 50,
                                  //   userId: FirebaseAuth.instance.currentUser!.uid,
                                  //   userName: "M.K. Malik",
                                  //   paymentMethod: "UPI",
                                  //   comment: "Water",
                                  // );
                                },
                                child: Container(
                                  width: size.width * 0.17,
                                  height: size.height * 0.06,
                                  child: Row(
                                    children: [
                                      Icon(Icons.account_balance_wallet),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                      Text(
                                        'Add',
                                        style: cardItemTextStyle.copyWith(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
