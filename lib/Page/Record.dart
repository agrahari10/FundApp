import 'package:flutter/material.dart';
import 'package:fund_manger/widgets/style.dart';

class Record extends StatefulWidget {
  const Record({Key? key}) : super(key: key);

  @override
  _RecordState createState() => _RecordState();
}

class _RecordState extends State<Record> {
  // String _currText = '';
  List<String> selectedList = [];
  List<String> allUsers = [
    'Adarsh',
    'Osama',
    'Avinash',
    'Rupesh',
    'Babunandan',
    'Malik'
  ];

  // void select(bool isChecked, index){
  //   // ignore: unnecessary_statements
  //   if  (isChecked == true){
  //     setState((){
  //       unselected.add(selected[index]);
  //       });
  //   if (isChecked == false){
  //     unselected.remove(selected[index]);
  //   }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height*1.1,
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
                        height: 30.0,
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
                          hintText: 'Item Name',
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
                      Text(
                        'Consumers',
                        style: cardItemTextStyle.copyWith(
                            color: Colors.white,
                            fontSize: size.height * 0.04,
                            fontWeight: FontWeight.normal),
                      ),
                      Column(
                        children: [
                          for (int i = 0; i < allUsers.length; i++)
                            Row(
                              children: [
                                SizedBox(
                                  height: size.height * 0.05,
                                  width: 200,
                                  child: CheckboxListTile(
                                    onChanged: (value) {
                                      if (mounted)
                                        setState(() {
                                          if (selectedList
                                              .contains(allUsers[i]))
                                            selectedList.remove(allUsers[i]);
                                          else
                                            selectedList.add(allUsers[i]);
                                        });
                                      print(selectedList);
                                    },
                                    title: Text(
                                      allUsers[i],
                                      style: cardItemTextStyle.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    value: selectedList.contains(allUsers[i]),
                                  ),
                                ),
                              ],
                            ),
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
