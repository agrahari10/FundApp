import 'package:flutter/material.dart';
import 'package:fund_manger/Page/addfund.dart';
import 'package:fund_manger/widgets/style.dart';

class CardView extends StatelessWidget {
  const CardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String item = 'Sabzi';
    double amount = 100;

    String date = "06 November 2021";
    String time = "20:10";
    String recordedBy = "Avinash";
    String consumer = "Avinash, Adarsh, Osama";
    String comment = "Comment if any (Optional)";

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
                    padding: EdgeInsets.only(right: size.width*0.9),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        
                      ),
                  ),
              ),),
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
                  '$item',
                  style: cardItemTextStyle.copyWith(
                    fontSize: size.width * 0.07,
                    color: Color(0xffFFFFFF),
                  ),
                ),
              ),
              Container(
                child: Text('Rs. $amount',
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
                            'Date: $date\n\nTime: $time\n\nRecorded by: $recordedBy\n\nConsumer:\n$consumer\n\nComment$comment',
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
                    onTap: (){
                    },
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
