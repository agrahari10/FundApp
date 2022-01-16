import 'package:flutter/material.dart';
import 'package:fund_manger/widgets/style.dart';

class MemberCard extends StatelessWidget {
  const MemberCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.1,
      child: GestureDetector(
        onTap: () {
          // onPressed();
        },
        child: Padding(
          padding:  EdgeInsets.only(top: size.width*0.01,left: size.width*0.0000000001,right: size.width*0.001),
          child: Card(
            child: ListTile(
              title: Text(
                'Available fund:',
                style: cardItemTextStyle.copyWith(
                    color: Colors.black, fontSize: size.width * 0.05),
              ),
              subtitle: Text(
                'Rs.0',
                style: cardItemTextStyle.copyWith(
                    fontSize: size.width * 0.04, color: Colors.black),
              ),
              trailing: Icon(
                Icons.chevron_right,
                size: size.width * 0.1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}