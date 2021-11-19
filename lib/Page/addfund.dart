import 'package:flutter/material.dart';
import 'package:fund_manger/widgets/style.dart';

class AddFund extends StatefulWidget {
  const AddFund({Key? key}) : super(key: key);

  @override
  _AddFundState createState() => _AddFundState();
}

class _AddFundState extends State<AddFund> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = false;
    int _radioSelected = 1;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height * 1.1,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFF12711), Color(0xFFF5AF19)])),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 8, top: 5)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.chevron_left,
                        size: size.height * 0.06,
                      ),
                    ),
                  ],
                ),
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
                        height: 20.0,
                      ),
                      TextField(
                        obscureText: true,
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
                        obscureText: true,
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
                              groupValue: _radioSelected,
                              activeColor: Colors.blue,
                              onChanged: (value) {
                                setState(() {
                                  _radioSelected = 1;
                                  value = 1;
                                  // _radioVal = 'male';
                                });
                              },
                            ),
                          ),
                          Text('UPI'),
                          Radio(
                            value: 0,
                            groupValue: _radioSelected,
                            activeColor: Colors.blue,
                            onChanged: (value) {
                              setState(() {
                                _radioSelected = 1;
                                value = 1;
                                // _radioVal = 'male';
                              });
                            },
                          ),
                          Text('Cash'),
                          Radio(
                            value: 0,
                            groupValue: _radioSelected,
                            activeColor: Colors.blue,
                            onChanged: (value) {
                              setState(() {
                                _radioSelected = 1;
                                value = 1;
                                // _radioVal = 'male';
                              });
                            },
                          ),
                          Text('Other'),

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
                          onPressed: () {},
                          child: Container(
                            width: size.width*0.17,
                            height: size.height*0.06,
                            child: Row(
                              children: [
                                Icon(Icons.account_balance_wallet),
                                SizedBox(width: 10.0,),
                                Text('Add',style: cardItemTextStyle.copyWith(fontSize: 17,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
