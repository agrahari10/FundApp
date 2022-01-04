import 'package:flutter/material.dart';
import 'package:fund_manger/Page/Cardoverview.dart';
import 'package:fund_manger/widgets/Reusable.dart';
import 'package:fund_manger/widgets/membersCard.dart';
import 'package:fund_manger/widgets/style.dart';
// import 'package:fund_manger/Page/funds.dart';
// import 'package:fund_manger/widgets/Reusable.dart';
// import 'package:fund_manger/widgets/style.dart';

// class Members extends StatelessWidget {
//   const Members({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     String item = 'Sabczi';
//     double amountt = 1070;

//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Container(
//             width: size.width,
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                     begin: Alignment.topRight,
//                     end: Alignment.bottomRight,
//                     colors: [Color(0xFFF12711), Color(0xFFF5AF19)])),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Padding(padding: EdgeInsets.only(left: 8, top: 5)),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Icon(
//                         Icons.chevron_left,
//                         size: size.height * 0.06,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   child: Text(
//                     '$item',
//                     style: cardItemTextStyle.copyWith(
//                       fontSize: size.width * 0.07,
//                       color: Color(0xffFFFFFF),
//                     ),
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(
//                           top: size.width * 0.025,
//                           left: size.width * 0.05,
//                           right: size.width * 0.05),
//                       child: Divider(
//                         color: Colors.white,
//                         thickness: 1,
//                       ),
//                     ),
//                     Padding(
//                           padding: EdgeInsets.only(top:size.width*0.15,left: size.width*0.02,right:size.width*0.02,bottom: size.width*0.04),
//                           child: Column(
//                             children: [
//                               for (int i = 0 ; i <= 10;i++)
//                               Reusablecard(item: item, size: size, amount: 0,onPressed: (){},),
//                               // Reusablecard(item: item, size: size, amount: amount),
//                             ],
//                           ),
//                         ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class Members extends StatefulWidget {
  const Members({ Key? key }) : super(key: key);

  @override
  _MembersState createState() => _MembersState();
}

class _MembersState extends State<Members> {
  @override
  Widget build(BuildContext context) {
    List<String> membersList = ['Avinash','Osama','Babunandan','Malik','Rupesh','Adarsh'];
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
                          'Members',
                          style: cardItemTextStyle.copyWith(
                            fontSize: size.width * 0.07,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                      // Container(
                      //   child: Text('Rs.$balance',
                      //       style: cardItemTextStyle.copyWith(
                      //         fontSize: size.width * 0.1,
                      //         color: Color(0xffFFFFFF),
                      //       )),
                      // ),
                      Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          children: [
                            for (int i = 0; i <= membersList.length; i++)
                            // MemberCard()
                              Reusablecard(
                                  item: '22', size: size, amount: 233,
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
        
      ),
    );
  }
}