import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jagobisnis/common/config.dart';
import 'package:jagobisnis/common/toast/alert_dialog.dart';
import 'package:jagobisnis/common/widget/common_divider.dart';
import 'package:jagobisnis/common/widget/common_scaffold.dart';
// import 'package:jagobisnis/common/widget/profile_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:jagobisnis/database/DatabaseHelper.dart';
import 'package:jagobisnis/common/config.dart';
import 'package:jagobisnis/common/uidata.dart';

class UpdateProfile extends StatefulWidget {
  BuildContext context;
  @override
  UpdateProfileState createState() {
    return new UpdateProfileState();
  }
}

class UpdateProfileState extends State<UpdateProfile> {
  Size deviceSize;
  String emailMember = "dndini2@gmail.com",teleponMember = "081223744803",referalEmail = "admin@jagobisnis.com";
  String namaMember = "Dini Yuliani";
  String nama_bank = "BCA";
  String nama_rekening = "Ibu Yuliani";
  String nomor_rekening = "0348268";
  String alamatMember = "jl. Dago barat no 73 A";
  String lisensi = "PREMIUM";
  String foto = "";
  String status = "AKTIF";
  int saldoMember;
  String jumlahPenukaran = "0";
  String jumlahAbsen = "0";
  ConfigClass configClass = new ConfigClass();
  var databaseHelper = new  DatabaseHelper() ;
  BuildContext publicContext;
  @override
  void initState() {
    super.initState();
   
  }
   Future<String> getUpdateProfile() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     emailMember = prefs.getString('sessionEmail');
     return await http.post(configClass.profile(), body: {"email" : emailMember}).then((response) {
          // print(response.body);
          // var extractdata = JSON.jsonDecode(response.body);
          // List dataResult;
          // dataResult = extractdata["result"];
          // emailMember = dataResult[0]["content"]["email"];
          // namaMember =  dataResult[0]["content"]["nama"];
          // teleponMember =  dataResult[0]["content"]["nomor_telepon"];
          // nama_bank =  dataResult[0]["content"]["nama_bank"];
          // nomor_rekening =  dataResult[0]["content"]["nomor_rekening"];
          // nama_rekening =  dataResult[0]["content"]["nama_rekening"];
          // alamatMember =  dataResult[0]["content"]["alamat"];
          // referalEmail =  dataResult[0]["content"]["referal"];
          // lisensi =  dataResult[0]["content"]["lisensi"];
          // foto =  dataResult[0]["content"]["foto"];
          // status =  dataResult[0]["content"]["status"];

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

  


  Widget bodyData() { 
    int _act = 2;
    TextStyle whiteText = TextStyle(color: Colors.white);
    var warnaStatus = Colors.orangeAccent;
    if(lisensi == "FREE"){
      warnaStatus = Colors.orangeAccent;
    }else {
      warnaStatus = Colors.greenAccent;
    }
    final Color color1 = Colors.blue;
    final Color color2 = Colors.blue.shade200;
    final Color color3 = Colors.blue.shade400;
    final Color color4 = Colors.blueGrey;
    final TextEditingController _alamatController = new TextEditingController();

    return SingleChildScrollView(
      
      child:  
              Stack(
                children: <Widget>[
                  Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [color3, color4],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
            Container(
              height: 450,
              width: 300,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(30)),
                  color: color2),
            ),
            Container(
              height: 100,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(30)),
                  color: color1),
            ),
                  Container(
                    width: double.infinity,
                    height: 330,
                    color: color1,
                  ),
                  
                  Column(
                    children: <Widget>[
                      Container(
                        height: 90,
                        margin: EdgeInsets.only(top: 60),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: CachedNetworkImage(
                              imageUrl: foto,
                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                              fit: BoxFit.cover,
                            )
                    ),
                      ),
                      Container(
                          padding: const EdgeInsets.fromLTRB(200,0,0,10),
                          child: RaisedButton(
                            child: Text("Change Photo".toUpperCase()),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                            onPressed: (){
                              // Navigator.push(context, MaterialPageRoute(
                              //   builder: (_) => RecipeDetailsPage()
                              // ));
                            },
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.all(4),
                      ),
                      Text(
                        namaMember,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.all(4),
                      ),
                      Container(
                              padding: const EdgeInsets.all(4.0),
                              height: 20.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: warnaStatus
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    lisensi,
                                    style:
                                        whiteText.copyWith(fontWeight: FontWeight.bold, fontSize: 10.0),
                                  ),
                                ],
                              ),
                            ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Card(
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "User Information",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black38,
                                    ),
                                    Container(
                                        child: Column(
                                      children: <Widget>[
                                      
                                        ListTile(
                                          leading: Icon(Icons.email),
                                          title: Text("Email"),
                                          subtitle: Text(emailMember),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.phone),
                                          title: Text("Phone"),
                                          subtitle: Text(teleponMember),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.local_atm),
                                          title: Text("Bank"),
                                          subtitle: Text(nama_bank + " " +nomor_rekening + " a/n "+ nama_rekening),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.group),
                                          title: Text("Referal"),
                                          subtitle: Text(referalEmail),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.home),
                                          title: TextField(
                                                controller: _alamatController,
                                                style: TextStyle(color: Colors.blue),
                                                decoration: InputDecoration(
                                                  hintText: "Alamat",
                                                  hintStyle: TextStyle(color: Colors.blue.shade200),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
         
    );
  }

  Widget _scaffold() => CommonScaffold(
        appTitle: "UpdateProfile",
        bodyData: 
              FutureBuilder(
              future: getUpdateProfile(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  var extractdata = JSON.jsonDecode(snapshot.data);
                    List dataResult;
                    dataResult = extractdata["result"];
                    namaMember =  dataResult[0]["content"][0]['nama'].toString();
                    teleponMember =  dataResult[0]["content"][0]["nomor_telepon"];
                    nama_bank =  dataResult[0]["content"][0]["nama_bank"];
                    nomor_rekening =  dataResult[0]["content"][0]["nomor_rekening"];
                    nama_rekening =  dataResult[0]["content"][0]["nama_rekening"];
                    alamatMember =  dataResult[0]["content"][0]["alamat"];
                    referalEmail =  dataResult[0]["content"][0]["referal"];
                    lisensi =  dataResult[0]["content"][0]["lisensi"];
                    foto =  dataResult[0]["content"][0]["foto"];
                    status =  dataResult[0]["content"][0]["status"];
                  // tampilkan dvarata
                  return bodyData();
                } else {
                  return Center (
                      child: CircularProgressIndicator()
                  );
                }
              },
            ),

        showFAB: true,
        showDrawer: true,
        floatingIcon: Icons.save,
        eventFloatButton: (){
          _customAlertDialog(publicContext, AlertDialogType.WARNING,"Warning",  "Update Profile Di Block");
          
        },
      );



  @override
  Widget build(BuildContext context) {
    // getDataAccount();
    deviceSize = MediaQuery.of(context).size;
    publicContext = context;
    return _scaffold();
  }

  _customAlertDialog(BuildContext context, AlertDialogType type, String titleAlert,String descAlert) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          type: type,
          title: titleAlert,
          content: descAlert,
        );
      },
    );
  }

}

