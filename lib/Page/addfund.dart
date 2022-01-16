import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_manger/models/userModel.dart';
import 'package:fund_manger/repository/dbRepository.dart';
import 'package:fund_manger/widgets/style.dart';

class AddFund extends StatefulWidget {
  const AddFund({required this.currentUser});
  final UserModel currentUser;

  @override
  _AddFundState createState() => _AddFundState();
}

String selectedPaymentMethod = "";

class _AddFundState extends State<AddFund> {
  List<String> paymentMethods = ["UPI", "Cash", "Other"];
  DbRepository _dbRepository = DbRepository();

  String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  String comment = "";
  double amount = 0.0;

  int _radioSelected = 0; // Initial selected radiobutton is UPI
  setSelectedRadio(int val) {
    setState(() {
      _radioSelected = val;
      selectedPaymentMethod = paymentMethods[val];
      print(selectedPaymentMethod);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.currentUser.name);
    // bool isSelected = true;
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
              height: size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFF12711), Color(0xFFF5AF19)])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: 100, top: size.width * 0.25)),
                    ],
                  ),
                  Container(
                    child: Text(
                      'Add Fund',
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
                          height: 20.0,
                        ),
                        TextField(
                          onChanged: (val) {
                            amount = double.parse(val);
                          },
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(size.height * 0.01),
                            ),
                            hintText: 'Amount',
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextField(
                          onChanged: (val) {
                            comment = val;
                          },
                          obscureText: false,
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
                        Center(
                          child: Text(
                            'Payment method',
                            style: cardItemTextStyle.copyWith(
                                color: Colors.white,
                                fontSize: size.height * 0.04,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 60),
                              child: Radio(
                                value: 0,
                                groupValue: _radioSelected, // for UPI
                                activeColor: Colors.black,
                                onChanged: (val) {
                                  setSelectedRadio(val as int);
                                },
                              ),
                            ),
                            Text(paymentMethods[0]),
                            Radio(
                              value: 1,
                              groupValue: _radioSelected,
                              activeColor: Colors.black,
                              onChanged: (val) {
                                setSelectedRadio(val as int);
                              },
                            ),
                            Text(paymentMethods[1]),
                            Radio(
                                value: 2,
                                groupValue: _radioSelected,
                                activeColor: Colors.black,
                                onChanged: (val) {
                                  setSelectedRadio(val as int);
                                }),
                            Text(paymentMethods[2]),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: ElevatedButton(
                            child:Container(
                              width: size.width * 0.17,
                              height: size.height * 0.06,
                              child: Row(
                                children: [
                                  Icon(Icons.account_balance_wallet),
                                  SizedBox(
                                    width: 10.0,
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
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white, // background
                              onPrimary: Colors.black, // foreground
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Payment processing. Please wait')));
                              

                              showDialog(context: context, builder: (BuildContext dialogcontext) {
                                return AlertDialog(
                                  title: Text('Do you want to add amount ?'),
                                  actions: [
                                    TextButton(onPressed: (){
                                      _dbRepository
                                      .addFund(
                                      amount: amount,
                                      userId: currentUserId,
                                      userName: widget.currentUser.name,
                                      paymentMethod: selectedPaymentMethod,
                                    ) .then((value) {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text(
                                              'Fund added in pending section. Contact Admin')));
                                      Future.delayed(Duration(milliseconds: 200))
                                          .then((value) {
                                        Navigator.of(dialogcontext).pop();
                                        Navigator.of(context).pop();
                                      });
                                    },);

                                    }, child: Text('Yes')),
                                    TextButton(onPressed:(){
                                      Navigator.of(dialogcontext).pop();
                                    } , child: Text('No')),
                                    
                                  ],
                                );
                              });
                              
                              // add amount by user

                            //   _dbRepository
                            //       .addFund(
                            //     amount: amount,
                            //     userId: currentUserId,
                            //     userName: widget.currentUser.name,
                            //     paymentMethod: selectedPaymentMethod,
                            //   )
                            //       .then((value) {
                            //     ScaffoldMessenger.of(context)
                            //         .hideCurrentSnackBar();
                            //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //         content: Text(
                            //             'Fund added in pending section. Contact Admin')));
                            //     Future.delayed(Duration(seconds: 1))
                            //         .then((value) {
                            //       // Navigator.of(context).pop();
                            //     });
                            //   });
                            // },
                            
                             }, )
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
