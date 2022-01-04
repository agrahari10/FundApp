import 'package:flutter/material.dart';
import 'package:fund_manger/Page/Cardoverview.dart';
import 'package:fund_manger/widgets/Reusable.dart';
import 'package:fund_manger/widgets/style.dart';

class SeprateMember extends StatefulWidget {
  const SeprateMember({ Key? key }) : super(key: key);

  @override
  _SeprateMemberState createState() => _SeprateMemberState();
}

class _SeprateMemberState extends State<SeprateMember> {
  @override
  Widget build(BuildContext context) {
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
                      colors: [Color(0xFFF12711), Color(0xFFF12711)]))
              ),),
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
                Padding(
                  padding: EdgeInsets.all(size.width * 0.05),
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          'Available Funds',
                          style: cardItemTextStyle.copyWith(
                            fontSize: size.width * 0.07,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                      Container(
                        child: Text('Rs.0',
                            style: cardItemTextStyle.copyWith(
                              fontSize: size.width * 0.1,
                              color: Color(0xffFFFFFF),
                            )),
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          children: [
                            for (int i = 0; i <= 6; i++)
                              Reusablecard(
                                  item: 'dcdd', size: size, amount: 1222,
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CardView()));
                                  },),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),);
  }
}