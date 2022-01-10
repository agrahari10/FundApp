import 'package:flutter/material.dart';
import 'package:fund_manger/widgets/style.dart';

class Reusablecard extends StatelessWidget {
  const Reusablecard({
    Key? key,
    required this.item,
    required this.size,
    required this.amount,
    required this.onPressed,
  }) : super(key: key);

  final String item;
  final Size size;
  final double amount;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.1,
      child: GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Padding(
          padding: EdgeInsets.only(
              top: size.width * 0.01,
              left: size.width * 0.0000000001,
              right: size.width * 0.001),
          child: Card(
            child: ListTile(
              title: Text(
                '$item',
                style: cardItemTextStyle.copyWith(
                    color: Colors.black, fontSize: size.width * 0.05),
              ),
              subtitle: Text(
                'Rs.$amount',
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
