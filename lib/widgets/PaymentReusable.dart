import 'package:flutter/material.dart';
import 'package:fund_manger/widgets/style.dart';

class PaymentReusablecard extends StatelessWidget {
  const PaymentReusablecard({
    Key? key,
    required this.Date,
    required this.size,
    required this.amount,
  }) : super(key: key);

  final double amount;
  final Size size;
  final String Date;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.12,
      child: GestureDetector(
        onTap: () {
          print('33' * 100);
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: ListTile(
              title: Text(
                'Rs.$amount',
                style: cardItemTextStyle.copyWith(
                    color: Colors.black, fontSize: size.width * 0.05),
              ),
              subtitle: Text(
                '$Date',
                style: cardItemTextStyle.copyWith(
                    fontSize: size.width * 0.04,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
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