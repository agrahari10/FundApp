import 'package:flutter/material.dart';
import 'package:fund_manger/widgets/style.dart';

class Reusablecard extends StatelessWidget {
  const Reusablecard({
    Key? key,
    required this.item,
    required this.size,
    required this.amount,
  }) : super(key: key);

  final String item;
  final Size size;
  final int amount;

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