import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_manger/Page/Cardoverview.dart';
import 'package:fund_manger/Page/addfund.dart';
import 'package:fund_manger/models/userModel.dart';
import 'package:fund_manger/repository/dbRepository.dart';
import 'package:fund_manger/widgets/Reusable.dart';
import 'package:fund_manger/widgets/membersCard.dart';
import 'package:fund_manger/widgets/style.dart';

class Members extends StatefulWidget {
  const Members({Key? key}) : super(key: key);

  @override
  _MembersState createState() => _MembersState();
}

class _MembersState extends State<Members> {
  bool isDataLoaded = false;

  List<UserModel> members = [];
  late UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    DbRepository _dbRepo = DbRepository();
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    var balance;

    if (!isDataLoaded) {
      members = [];
      _dbRepo.getAuthorizedUsers().then((users) {
        for (UserModel user in users) {
          members.add(user);
          if (user.uuid == currentUserId) {
            currentUser = user;
          }
        }

        // _dbRepo.getUserFundAmount(uuid: currentUserId).then((amount) {
        //   balance = amount;
        // });
        balance = currentUser.fundAmount;

        if (mounted)
          setState(() {
            isDataLoaded = true;
          });
      });
    }
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Container(     // floating disable while loading data 
          child: isDataLoaded ? FloatingActionButton.extended(
            backgroundColor: Colors.black87,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddFund(
                        currentUser: currentUser,
                      )));
            },
            label:Row(
              children: [
                Icon(Icons.add),
                Text('Add Fund'),
              ],
            )
          ):SizedBox(),
        ),
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
          child: isDataLoaded
              ? Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFF12711),
                        Color(0xFFF5AF19),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(size.width * 0.05),
                        child: Column(
                          children: [
                            Container(
                              child: Text(
                                'Members',
                                style: cardItemTextStyle.copyWith(
                                  fontSize: size.width * 0.07,
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                            ),
                            // Container(
                            //   child: Text('Rs.$balance',
                            //       style: cardItemTextStyle.copyWith(
                            //         fontSize: size.width * 0.1,
                            //         color: Color(0xffFFFFFF),
                            //       )),
                            // ),
                            Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Column(
                                children: [
                                  for (int i = 0; i < members.length; i++)
                                    // MemberCard()
                                    Reusablecard(
                                      item: members[i].name,
                                      size: size,
                                      amount: members[i].fundAmount,
                                      onPressed: () {
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => CardView()));
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
                )
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
