import 'dart:convert';
import 'dart:typed_data';

import 'package:jagobisnis/common/config.dart';
import 'package:jagobisnis/common/toast/alert_dialog.dart';
import 'package:jagobisnis/database/DatabaseHelper.dart';
import 'package:jagobisnis/common/widget/common_scaffold.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jagobisnis/pages/detailArsipPage.dart';
import 'package:jagobisnis/pages/detailTraining.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';

class ArsipPage extends StatefulWidget {
  ArsipPage({Key key}) : super(key: key);
  static final String path = "lib/src/pages/lists/list2.dart";

  _ArsipPageState createState() => _ArsipPageState();
}

class _ArsipPageState extends State<ArsipPage> {
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);
  final scaffoldKey = GlobalKey<ScaffoldState>();
    ConfigClass configClass = new ConfigClass();
  var databaseHelper = new  DatabaseHelper() ;
  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);
  var db = new DatabaseHelper();
  final TextStyle whiteText = TextStyle(color: Colors.white);

  String emailMemberSession ;
  bool isPerformingRequest = false;
  ScrollController _scrollController = new ScrollController();

  List<Item> items ;
  bool _loadingMore;
  bool _hasMoreItems;
  int _maxItems ;
  String lastIdInserting  = "";
  int fromPost = 10;

  Size deviceSize;
   @override
  void initState() {
    super.initState();
      items = List<Item>();

    (() async {
    })();
    
    
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    
    return CommonScaffold(
      scaffoldKey: scaffoldKey,
      appTitle: "Kuliah WhatsApp",
      showDrawer: true,
      showFAB: false,
      actionFirstIcon: Icons.shopping_cart,
      bodyData: FutureBuilder(
          future: _initialLoad(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                // return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                return IncrementallyLoadingListView(
                  hasMore: () => _hasMoreItems,
                  itemCount: () => items.length,
                  loadMore: () async {
                    
                    await _loadMoreItems();
                  },
                  // onLoadMore: () {
                  //   setState(() {
                  //     _loadingMore = true;
                  //   });
                  // },
                  // onLoadMoreFinished: () {
                  //   setState(() {
                  //     _loadingMore = false;
                  //   });
                  // },
                  loadMoreOffsetFromBottom: 1,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    //(_loadingMore ?? false) &&
                    if ( index == items.length - 1 && (items.length != _maxItems )) {
                      return Column(
                        children: <Widget>[
                          ItemCard(item: item),
                          PlaceholderItemCard(item: item),
                        ],
                      );
                    }else{
                      return ItemCard(item: item);
                    }
                  },
                );
              default:
                return Text('Something went wrong');
            }
          },
        ),
    );
    
  }


  Future _initialLoad() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     emailMemberSession = prefs.getString('sessionEmail').toString();
     var dbClient = await db.db;
      await http.post(configClass.arsipKulWA(), body: {"email" : prefs.getString('sessionEmail').toString(),"from" : "0","to":"10"}).then((response) {
        print(response.body);
        var extractdata = JSON.jsonDecode(response.body);
        List dataResult;
        String err,cek;
        dataResult = extractdata["result"];
        List<dynamic> dataContent = dataResult[0]["content"];
        _maxItems = 0;
        for (var i = 0; i < dataContent.length; i++) {
          _maxItems = int.parse(dataContent[i]['maxItem']);
            items.add(Item(
              dataContent[i]['id_materi'].toString(),
              dataContent[i]['tanggal'].toString(),
              dataContent[i]['judul_materi'].toString(),
              dataContent[i]['deskripsi'].toString(),
              dataContent[i]['pemateri'].toString(),
              dataContent[i]['status'].toString(),
            ));
        }
       

       
        
       
      });
      // if(items.length < _maxItems){
      //   _hasMoreItems = true;
      // }else{
      //   _hasMoreItems = false;
      // }
      _hasMoreItems = items.length < _maxItems;
      // _hasMoreItems = false;
    
  }
  Future _loadMoreItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     emailMemberSession = prefs.getString('sessionEmail').toString();
     var dbClient = await db.db;
        print("executed "+fromPost.toString());

     await http.post(configClass.arsipKulWA(), body: {"email" : emailMemberSession,"from" : fromPost.toString() ,"to":"10"}).then((response) {
        // print(response.body);
        var extractdata = JSON.jsonDecode(response.body);
        List dataResult;
        String err,cek;
        dataResult = extractdata["result"];
        List<dynamic> dataContent = dataResult[0]["content"];
        for (var i = 0; i < dataContent.length; i++) {
          _maxItems = int.parse(dataContent[i]['maxItem']);
          
            items.add(Item(
              dataContent[i]['id_materi'].toString(),
              dataContent[i]['tanggal'].toString(),
              dataContent[i]['judul_materi'].toString(),
              dataContent[i]['deskripsi'].toString(),
              dataContent[i]['pemateri'].toString(),
              dataContent[i]['status'].toString(),
            ));
            lastIdInserting = dataContent[i]['id'].toString();
            fromPost += 1;
        }
       
      });
      _hasMoreItems = items.length < _maxItems;
      // if(items.length < _maxItems){
      //   _hasMoreItems = true;
      // }else{
      //   _hasMoreItems = false;
      // }
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

class Item {
  final String id_materi;
  final String tanggal;
  final String judul_materi;
  final String deskripsi;
  final String pemateri;
  final String status;

  Item(this.id_materi,this.tanggal,this.judul_materi,this.deskripsi,this.pemateri,this.status);
}


class ItemCard extends StatelessWidget {
  
  const ItemCard({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Item item;
  
  @override
  Widget build(BuildContext context) {
  Size deviceSize = MediaQuery.of(context).size;
  TextStyle whiteText = TextStyle(color: Colors.white);
  final primary = Color(0xff696b9e);
  var warnaStatus ;
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  const Color profile_info_background = Color(0xFF3775FD);
  const Color profile_info_categories_background = Color(0xFFF6F5F8);
  const Color profile_info_address = Color(0xFF8D7AEE);
  const Color profile_info_privacy = Color(0xFFF369B7);
  const Color profile_info_general = Color(0xFFFFC85B);
  const Color profile_info_notification = Color(0xFF5DD1D3);
  const Color profile_item_color = Color(0xFFC4C5C9);
    warnaStatus = Colors.orangeAccent;

    return GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
              width: double.infinity,
              height: 110,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Container(
                  //   width: 50,
                  //   height: 50,
                  //   margin: EdgeInsets.only(right: 15),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(50),
                  //     // border: Border.all(width: 3, color: secondary),
                        
                  //   ), 
                  //   child: CircleAvatar(
                  //                 backgroundImage: NetworkImage(item.foto),
                  //                 backgroundColor: Colors.black,
                  //                 foregroundColor: Colors.black,
                  //                 radius: 24.0,
                  //             ),
                  // ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.tanggal,
                          style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: <Widget>[
                            Text(item.judul_materi,
                                style: TextStyle(
                                    color: primary, fontSize: 13, letterSpacing: .3)),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: <Widget>[
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
                                    item.pemateri,
                                    style:
                                        whiteText.copyWith(fontWeight: FontWeight.bold, fontSize: 10.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: <Widget>[
                        //     Align(
                        //             alignment: Alignment.centerRight,
                        //             child: Container(
                        //               child: Text(
                        //                   item.status,
                        //                   textAlign: TextAlign.right,
                        //                 ),
                        //               ),
                        //             ),
                              
                        //   ]
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            onTap: (){
                        var codec = latin1.fuse(base64);
                        // print(codec.decode(item.deskripsi));
                        Navigator.push(
                                context,
                        new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new DetailArsipPage(
                                item.id_materi,
                                item.tanggal,
                                item.judul_materi,
                                // stringToBase64.decode(item.deskripsi.toString()),
                                codec.decode(item.deskripsi),
                                item.pemateri,
                                item.status,
                                ),
                        ));
                        
                
                      },
    );
  }
}

class PlaceholderItemCard extends StatelessWidget {
  const PlaceholderItemCard({Key key, @required this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    TextStyle whiteText = TextStyle(color: Colors.white);
  final primary = Color(0xff696b9e);
  var warnaStatus = Colors.orangeAccent;

  warnaStatus = Colors.blueAccent;
    return Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child:Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.transparent,
              ),
              width: double.infinity,
              height: 110,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      // border: Border.all(width: 3, color: secondary),
                        
                    ), 
                    child: Image.asset(
                                'assets/shopping.png',
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                              ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "########",
                          style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: <Widget>[
                            Text("####-##-##",
                                style: TextStyle(
                                    color: primary, fontSize: 13, letterSpacing: .3)),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: <Widget>[
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
                                    item.status,
                                    style:
                                        whiteText.copyWith(fontWeight: FontWeight.bold, fontSize: 10.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      child: Text(
                                          "#xx",
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ),
                              
                          ]
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
    );
  }
}