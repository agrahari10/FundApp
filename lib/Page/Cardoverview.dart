import 'package:flutter/material.dart';
import 'package:fund_manger/Page/addfund.dart';
import 'package:fund_manger/repository/dbRepository.dart';
import 'package:fund_manger/widgets/style.dart';

class CardView extends StatefulWidget {
  final String item;
  final double amount;
  final List<dynamic> consumersList;
  final List<dynamic> consumerNames;
  final DateTime dateTime;
  final String comment;
  final String recordedBy;
  const CardView({
    required this.item,
    required this.amount,
    required this.consumersList,
    required this.consumerNames,
    required this.dateTime,
    required this.comment,
    required this.recordedBy,
  });

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    String consumersStr = "";

    for (String consumerName in widget.consumerNames) {
      consumersStr += consumerName + "\n";
    }

    String date =
        "${widget.dateTime.day} / ${widget.dateTime.month} / ${widget.dateTime.year}";
    String time = "${widget.dateTime.hour}:${widget.dateTime.minute}";

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
                    colors: [Color(0xFFF12711), Color(0xFFF12711)])),
            child: Padding(
              padding: EdgeInsets.only(right: size.width * 0.9),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        body: Container(
          width: size.width,
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
                ],
              ),
              Container(
                child: Text(
                  '${widget.item}',
                  style: cardItemTextStyle.copyWith(
                    fontSize: size.width * 0.07,
                    color: Color(0xffFFFFFF),
                  ),
                ),
              ),
              Container(
                child: Text('Rs. ${widget.amount}',
                    style: cardItemTextStyle.copyWith(
                      fontSize: size.width * 0.05,
                      color: Color(0xffFFFFFF),
                    )),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.width * 0.025,
                        left: size.width * 0.025,
                        right: size.width * 0.025),
                    child: Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                  ),
                  Card(
                    color: Color(0xFF37373799),
                    margin: EdgeInsets.only(
                        top: size.width * 0.2,
                        bottom: size.width * 0.2,
                        left: size.width * 0.05,
                        right: size.width * 0.05),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(size.width * 0.05),
                          child: Text(
                            'Date: $date\n\nTime: $time\n\nRecorded by: ${widget.recordedBy}\n\nConsumer:\n$consumersStr\nComment: ${widget.comment}',
                            style: cardItemTextStyle.copyWith(
                                fontSize: size.width * 0.05,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.share_rounded,
                      size: size.height * 0.06,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
