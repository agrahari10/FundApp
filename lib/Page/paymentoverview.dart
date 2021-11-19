import 'package:flutter/material.dart';
import 'package:fund_manger/widgets/PaymentReusable.dart';
import 'package:fund_manger/widgets/style.dart';

import 'funds.dart';

class PaymentOverview extends StatelessWidget {
  const PaymentOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String item = 'Avinash Kumar';
    String remmingAccount = '120';
    String Date = '21 Nov 2021';
    double RemAmmount = 100;

    return Scaffold(
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
              Column(
                children: [
                  Container(
                    child: Text(
                      '$item',
                      style: cardItemTextStyle.copyWith(
                        fontSize: size.width * 0.07,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Remaining fund: Rs. $remmingAccount',
                      style: cardItemTextStyle.copyWith(
                        fontSize: size.width * 0.04,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.width * 0.025,
                        left: size.width * 0.05,
                        right: size.width * 0.05),
                    child: Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.width * 0.15,
                        left: size.width * 0.02,
                        right: size.width * 0.02,
                        bottom: size.width * 0.04),
                    child: Column(
                      children: [
                        for (int i = 0; i <= 3; i++)
                          PaymentReusablecard(
                              Date: Date, size: size, amount: RemAmmount),
                        // Reusablecard(item: item, size: size, amount: amount),
                      ],
                    ),
                  ),
                ],
              ),
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
            'Add fund',
            style: cardItemTextStyle.copyWith(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
    );
  }
}


