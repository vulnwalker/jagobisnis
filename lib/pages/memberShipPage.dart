import 'package:jagobisnis/common/config.dart';
import 'package:jagobisnis/common/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:jagobisnis/common/widget/common_divider.dart';
import 'package:jagobisnis/common/widget/common_scaffold.dart';
import 'package:jagobisnis/common/widget/profile_tile.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:jagobisnis/database/DatabaseHelper.dart';
import 'package:jagobisnis/common/uidata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberShip extends StatefulWidget {
  BuildContext context;
  @override
  MemberShipState createState() {
    return new MemberShipState();
  }
}

class MemberShipState extends State<MemberShip> {
  final TextStyle whiteText = TextStyle(color: Colors.white);
  final Color color1 = Colors.blue;
  final Color color2 = Colors.blue.shade200;
  final Color color3 = Colors.blue.shade400;
  final Color color4 = Colors.blueGrey;
  Size deviceSize;
  String emailMember = "vulnwalker@getnada.com",namaMember = "udin",teleponMember = "081223744803",referalEmail = "admin@jagobisnis.com";
  int saldoMember;
  int jumlahBarangTerjual = 0;
  double persenToPremium = 0;
  String personalOmset = "0";
  String personalProfit = "0";
  String teamOmset = "0";
  String teamProfit = "0";
  String totalProfit = "0";
  String totalLeads = "0";
  ConfigClass configClass = new ConfigClass();
  var databaseHelper = new  DatabaseHelper() ;


  @override
  void initState() {
    super.initState();
    // (() async {
    //     //  await getDataAccount();
    //     setState(() {
    //     });
    // })();
  
  }
  Future<String> getMemberComission() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     emailMember = prefs.getString('sessionEmail');
     return await http.post(configClass.memberCommision(), body: {"email" : emailMember}).then((response) {
          print(response.body);
          return response.body;
    });
   }
  @override
  void didChangeDependencies() {
        (() async {
        //  await getDataAccount();
        setState(() {
                  
        });
    })();
    super.didChangeDependencies();
    
  }

   //Column1
  Widget MemberShipColumn() => Container(
        height: deviceSize.height * 0.24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ProfileTile(
              title: "My MemberShip",
              subtitle: "",
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // IconButton(
                //   icon: Icon(Icons.chat),
                //   color: Colors.black,
                //   onPressed: () {},
                // ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(50.0)),
                    border: new Border.all(
                      color: Colors.black,
                      width: 4.0,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/logo.png"),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.black,
                    radius: 40.0,
                  ),
                ),
                // IconButton(
                //   icon: Icon(Icons.call),
                //   color: Colors.black,
                //   onPressed: () {},
                // ),
              ],
            )
          ],
        ),
      );

  //column2
Container _buildTile(
      {Color color, IconData icon, String title, String data}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 150.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            title,
            style: whiteText.copyWith(fontWeight: FontWeight.bold),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              child: Text(
                    data,
                    style:
                        whiteText.copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
            ),
          ),
        ],
      ),
    );
  }
  Widget progresColumn() => Container(
        decoration: BoxDecoration(
            color: Colors.blueAccent,
          ),
        height: deviceSize.height * 0.13,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Text("s"),
                    ),
                  ),
      );
 

  Widget bodyData() { 
//     const cellRed = Color(0xffc73232);
// const cellMustard = Color(0xffd7aa22);
// const cellGrey = Color(0xffcfd4e0);
// const cellBlue = Color(0xff1553be);
// const background = Color(0xff242830);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     SizedBox(
          //       height: 5.0,
          //     ),
          //     Text(
          //       "Progres to Premium",
          //       style: TextStyle(
          //           fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.black),
          //     ),
              
          //   ],
          // ),
          // RoundedProgressBar(
          //     childLeft: Text(""+persenToPremium.toString()+"%",
          //         style: TextStyle(color: Colors.black)),
          //     percent: persenToPremium,
          //     theme: RoundedProgressBarTheme.yellow
          // ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     SizedBox(
          //       height: 5.0,
          //     ),
          //     Text(
          //       jumlahBarangTerjual.toString()+" / 15 Barang",
          //       style: TextStyle(
          //           fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.black),
          //     ),
              
          //   ],
          // ),
          CommonDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: _buildTile(
                    color: Colors.grey,
                    icon: Icons.group,
                    title: "Total Member / Leads",
                    data: totalLeads,
                  ),
                ),
              ],
            ),
          ),
          // CommonDivider(),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Row(
          //     children: <Widget>[
          //       Expanded(
          //         child: _buildTile(
          //           color: Colors.blue,
          //           icon: Icons.shopping_cart,
          //           title: "Total Order",
          //           data: "0",
          //         ),
          //       ),
          //       const SizedBox(width: 16.0),
          //       Expanded(
          //         child: _buildTile(
          //           color: Colors.lightGreen,
          //           icon: Icons.favorite,
          //           title: "Paid",
          //           data: "0",
          //         ),
          //       ),
          //       const SizedBox(width: 16.0),
          //       Expanded(
          //         child: _buildTile(
          //           color: Colors.redAccent,
          //           icon: Icons.payment,
          //           title: "Unpaid",
          //           data: "0",
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          //  SizedBox(
          //     height: 10.0,
          //   ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Row(
          //     children: <Widget>[
          //       Expanded(
          //         flex: 2,
          //         child: _buildTile(
          //           color: color1,
          //           icon: Icons.portrait,
          //           title: "Personal Omset",
          //           data: personalOmset,
          //         ),
          //       ),
          //       const SizedBox(width: 16.0),
          //       Expanded(
          //         flex: 2,
          //         child: _buildTile(
          //           color: color2,
          //           icon: Icons.portrait,
          //           title: "Personal Profit",
          //           data: personalProfit,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 10.0),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Row(
          //     children: <Widget>[
          //       Expanded(
          //         flex: 2,
          //         child: _buildTile(
          //           color: Color(0xffd7aa22),
          //           icon: Icons.group,
          //           title: "Team Omset",
          //           data: teamOmset,
          //         ),
          //       ),
          //       const SizedBox(width: 16.0),
          //       Expanded(
          //         flex: 2,
          //         child: _buildTile(
          //           color: Colors.orange,
          //           icon: Icons.group,
          //           title: "Team Profit",
          //           data: teamProfit,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 10.0),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Row(
          //     children: <Widget>[
          //       Expanded(
          //         flex: 3,
          //         child: _buildTile(
          //           color: Colors.pink,
          //           icon: Icons.attach_money,
          //           title: "Total Profit",
          //           data: totalProfit,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _scaffold() => CommonScaffold(
        appTitle: "Membership",
        bodyData: 
        FutureBuilder(
              future: getMemberComission(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  var extractdata = JSON.jsonDecode(snapshot.data);
                    List dataResult;
                    dataResult = extractdata["result"];
                    // emailMember = dataResult[0]["content"]["email"];
                    // print(dataResult[0]["content"][0]["nama"]);
                    
                    personalProfit =  dataResult[0]["content"][0]['profit'].toString();
                    personalOmset =  dataResult[0]["content"][0]['omset_profit'].toString();
                    teamProfit =  dataResult[0]["content"][0]['komisi_referal'].toString();
                    teamOmset =  dataResult[0]["content"][0]['omset_referal'].toString();
                    jumlahBarangTerjual =  int.parse(dataResult[0]["content"][0]['jumlah_barang_terjual']);
                    totalProfit =  dataResult[0]["content"][0]['totalProfit'];
                    totalLeads =  dataResult[0]["content"][0]['totalLeads'];
                    persenToPremium =  double.parse(dataResult[0]["content"][0]['persenToPremium']);

                  // tampilkan dvarata
                  return bodyData();
                } else {
                  return Center (
                      child: CircularProgressIndicator()
                  );
                }
              },
            ),
        showFAB: false,
        showDrawer: true,
        
      );

  
 

  @override
  Widget build(BuildContext context) {
    // getDataAccount();
    deviceSize = MediaQuery.of(context).size;
    return _scaffold();
  }


}


