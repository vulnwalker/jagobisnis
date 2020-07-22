import 'dart:convert';
import 'dart:typed_data';

/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */
  
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import 'package:jagobisnis/common/assets.dart';
import 'package:jagobisnis/common/config.dart';
import 'package:jagobisnis/common/toast/alert_dialog.dart';
import 'package:jagobisnis/common/widget/common_scaffold.dart';
import 'package:jagobisnis/database/DatabaseHelper.dart';
import 'package:jagobisnis/pages/detailTraining.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
// import 'package:jagobisnis/src/pages/food/recipe_single.dart';
ConfigClass configClass = new ConfigClass();

class TrainingPage extends StatelessWidget {
  static final String path = "lib/src/pages/food/recipe_list.dart";
  // final Color color1 = Color(0xffB5192F);
  // final Color color2 = Color(0xffE21F3D);
  // final Color color3 = Color(0xffFE1949);
  // final Color color4 = Color(0xffF0631C);

  final Color color1 = Colors.blue;
  final Color color2 = Colors.blue.shade200;
  final Color color3 = Colors.blue.shade400;
  final Color color4 = Colors.blueGrey;
  var db = new DatabaseHelper();

  final List<String> images = [
    breakfast,
    burger,
    cupcake,
    frenchFries,
    fries,
    meal,
    pancake,
  ];
  BuildContext publicContext;
  @override
  Widget build(BuildContext context) {

    publicContext = context;
    return CommonScaffold(
        // scaffoldKey: scaffoldKey,
        appTitle: "Training Centre",
        showDrawer: true,
        showFAB: false,
        bodyData: FutureBuilder(
              future: getListChapter(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // var extractdata = jsonDecode(snapshot.data);
                  //   List dataResult;
                  //   dataResult = extractdata["result"];
                  //   namaProduk =  dataResult[0]["content"][0]['nama_produk'].toString();
                  //   deskripsiProduk =  dataResult[0]["content"][0]['deskripsi'].toString();
                  //   hargaProduk =  dataResult[0]["content"][0]['harga'].toString();
                  //   mainImage =  dataResult[0]["content"][0]['main_image'].toString();
                  //   profitProduk =  dataResult[0]["content"][0]['profit'].toString();
                  //   sourceMedia = jsonDecode(dataResult[0]["content"][0]['media'].toString());
                  return template(context,snapshot.data);
                } else {
                  return Center (
                      child: CircularProgressIndicator()
                  );
                }
              },
            ),
        );
  }
  Widget template(BuildContext context, Stack stack){
    return stack;
  }
  Widget _buildItem(BuildContext context, index, {bool large = false}) {
    return GestureDetector(
      onTap: (){
        // Navigator.push(context, MaterialPageRoute(
        //   builder: (_) => RecipeSinglePage()
        // ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        width: large ? 150 : 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      images[index % images.length],
                    ),
                    fit: BoxFit.cover,
                  )),
              height: large ? 180 : 150,
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Apa itu Jago Bisnis ?",
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            )
          ],
        ),
      ),
    );
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
  Future<Stack> getListChapter() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    // Uint8List base64Decode(String source) => base64.decode(source);
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    // String encoded = stringToBase64.encode(credentials);      // dXNlcm5hbWU6cGFzc3dvcmQ=
    // String decoded = stringToBase64.decode(encoded);          

     var dbClient = await db.db;
     var listWidget = <Widget>[];
     final formatter = new NumberFormat("#,###");

      await http.post(configClass.trainingListChapter(), body: {"email" : prefs.getString('sessionEmail').toString() }).then((response) {
        var extractdata = JSON.jsonDecode(response.body);
        List dataResult;
        String err,cek;
        dataResult = extractdata["result"];
        List<dynamic> dataContent = dataResult[0]["content"];
        listWidget.add( SizedBox(height: 20.0),);    
        for (var i = 0; i < dataContent.length; i++) {
              // dataContent[i]['id_member'].toString(),
              listWidget.add(Padding(
                    padding: const EdgeInsets.only(left: 16.0,top:10.0),
                    child: 
                            OutlineButton(
                              color: Colors.white,
                              textColor: Colors.white,
                              borderSide: BorderSide(color: Colors.white),
                              child: Text(dataContent[i]["nama_chapter"].toUpperCase()),
                              onPressed: () {
                                _customAlertDialog(publicContext, AlertDialogType.INFO, dataContent[i]["nama_chapter"], dataContent[i]["judul"]);

                              },
                            ),
                  )
              );
              listWidget.add(Padding(
                    padding: const EdgeInsets.only(left: 16.0,top:5.0),
                    child: Text(dataContent[i]["judul"].toUpperCase(), style: TextStyle(color: Colors.yellowAccent, fontSize: 20,fontWeight: FontWeight.bold),),
                              
                  ));


              listWidget.add(SizedBox(height: 10.0));
              List materiContent = dataContent[i]["detail_materi"];
              // print(materiContent[0]["judul_materi"].toString() + " halloo" );
              var listMateri = <Widget>[];
              
              for (var ab = 0; ab < materiContent.length; ab++) {
                listMateri.add(
                  GestureDetector(
                      onTap: (){
                        Navigator.push(
                                publicContext,
                        new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new DetailTrainingPage(
                                materiContent[ab]["id"],
                                materiContent[ab]["judul_materi"],
                                stringToBase64.decode(materiContent[ab]["deskripsi_materi"].toString()),
                                materiContent[ab]["video_souce"],
                                materiContent[ab]["thumbnail"],
                                materiContent[ab]["durasi_video"],
                                materiContent[ab]["youtube_source"],
                                materiContent[ab]["status"],
                                dataContent[i]["nama_chapter"],
                                ),
                        ));
                
                        // _customAlertDialog(publicContext, AlertDialogType.INFO, materiContent[ab]["judul_materi"], stringToBase64.decode(materiContent[ab]["deskripsi_materi"].toString()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        width: 300 ,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      materiContent[ab]["thumbnail"] ,
                                    ),
                                    fit: BoxFit.fill,
                                  )),
                              height: 180 ,
                            ),
                            SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0,),
                              child: Text(
                                materiContent[ab]["judul_materi"],
                                style: TextStyle(color: Colors.white, fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                );


              }
              listWidget.add(
                Container(
                    height: 230,
                    child: ListView(
                      padding: const EdgeInsets.only(left: 16.0),
                      scrollDirection: Axis.horizontal,
                      children: listMateri
                      // itemBuilder: (context, index) =>  _buildItem(context, index, large:  true),
                    ),
                  ),
              );
            
          
      }
          

        
      });
       
       
     
     
     
 
    return Stack(
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
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: listWidget 
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,

              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.black87,
                  suffixIcon: Icon(Icons.search, color: Colors.white70,),
                  filled: true,
                  hintText: "Cari materi",
                  hintStyle: TextStyle(color: Colors.white70)
                ),
              ),
            )
          ],
        );
   }

  
}
