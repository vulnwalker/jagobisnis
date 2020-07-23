import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jagobisnis/common/assets.dart';
import 'package:jagobisnis/common/widget/common_scaffold.dart';
// import 'package:jagobisnis/common/widget/profile_tile.dart';

import 'package:http/http.dart' as http;
import 'package:jagobisnis/common/widget/network_image.dart';
import 'package:jagobisnis/common/widget/rounded_bordered_container.dart';
import 'dart:convert' as JSON;
import 'package:jagobisnis/database/DatabaseHelper.dart';
import 'package:jagobisnis/common/config.dart';
// import 'package:jagobisnis/utils/uidata.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MainPage extends StatefulWidget {
  BuildContext context;
  @override
  MainPageState createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  Size deviceSize;
  
  int saldoMember;
  int penjualanHariIni = 0;
  int penjualanKemarin = 0;
  String jumlahPenukaran = "0";
  String jumlahAbsen = "0";
  final TextStyle whiteText = TextStyle(color: Colors.white);
  ConfigClass configClass = new ConfigClass();
  var databaseHelper = new  DatabaseHelper() ;
  SharedPreferences prefs;

  final Color color1 = Colors.blue;
  final Color color2 = Colors.blue.shade200;
  final Color color3 = Colors.blue.shade400;
  final Color color4 = Colors.blueGrey;
  YoutubePlayerController _controller;

  Future<String> getSession() async {
    prefs = await SharedPreferences.getInstance();
    return await http.post(configClass.memberCommision(), body: {"email" : prefs.getString('sessionEmail').toString()}).then((response) {
          print(response.body);
          return response.body;
    });
  }
  @override
  void initState() {
    super.initState();
    (() async {
        //  await getDataAccount();
        prefs = await SharedPreferences.getInstance();
        String idVideo = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=3pIPQhbdHKI&feature=youtu.be");
        _controller = YoutubePlayerController(
          initialVideoId: idVideo,
          flags: YoutubePlayerFlags(
            mute: false,
            autoPlay: true,
          ),
        );

        setState(() {
        });
    })();
  
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

  @override
  Widget build(BuildContext context) {
   
    return FutureBuilder(
          future: getSession(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
                var extractdata = JSON.jsonDecode(snapshot.data);
                List dataResult;
                dataResult = extractdata["result"];
                return CommonScaffold(
                appTitle: "Dashboard",
                bodyData: _buildBody(context),
                // showFAB: true,
                showDrawer: true,
                floatingIcon: Icons.edit,
                eventFloatButton: (){
                  // Navigator.of(context).pushNamed(UIData.profileRoute);
                },
              );
            } else {
              return Center (
                  child: CircularProgressIndicator()
              );
            }
          },
        );
  }


  
  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(),
          const SizedBox(height: 20.0),
          Container(
                margin: EdgeInsets.fromLTRB(16.0, 0,16.0,8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)
                ),
                padding: const EdgeInsets.all(16.0),
                child: YoutubePlayer(
                          controller: _controller,
                          showVideoProgressIndicator: true,
                          onReady: () {
                            print('Player is ready. ');
                          },
                        ),
          ),
          Container(
                margin: EdgeInsets.fromLTRB(16.0, 0,16.0,8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                        child: OutlineButton(
                                  color: Colors.green,
                                  textColor: Colors.white,
                                  borderSide: BorderSide(color: Colors.white),
                                  child:
                                   Text("\t\t\t\t\t\t\t\t\t\t\Join Grup Whatsapp\t\t\t\t\t\t\t\t\t\t ".toUpperCase(),
                                  //  textAlign: TextAlign.center
                                   ),
                                  onPressed: () {
                                    launch("https://api.whatsapp.com/send?phone=6287774305454&text=Saya%20mau%20join%20grup%20Jago%20Bisnis");
                                  },
                                ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                        child:  OutlineButton(
                                  color: Colors.white,
                                  textColor: Colors.white,
                                  borderSide: BorderSide(color: Colors.white),
                                  child: Text("Join Channel Telegram".toUpperCase()),
                                  onPressed: () {
                                    launch("https://t.me/joinchat/AAAAAE1TD47ROqNAV5Gd1w");
                                  },
                              ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                        child:  OutlineButton(
                                  color: Colors.white,
                                  textColor: Colors.white,
                                  borderSide: BorderSide(color: Colors.white),
                                  child: Text("Join Channel Youtube".toUpperCase()),
                                  onPressed: () {
                                    launch("https://www.youtube.com/channel/UCDpVtldFqJ2paszK6n1v34g");
                                  },
                              ),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.fromLTRB(35.0, 0,4.0,16.0),
                    //   decoration: BoxDecoration(
                    //     color: Colors.blue,
                    //     borderRadius: BorderRadius.circular(5.0)
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    //     child: 
                                // OutlineButton(
                                //   color: Colors.white,
                                //   textColor: Colors.white,
                                //   borderSide: BorderSide(color: Colors.white),
                                //   child: Text("Telegram".toUpperCase()),
                                //   onPressed: () {
                                //     launch("https://t.me/joinchat/AAAAAE1TD47ROqNAV5Gd1w");
                                //   },
                                // ),
                    //   ),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.fromLTRB(4.0, 0,4.0,16.0),
                    //   decoration: BoxDecoration(
                    //     color: Colors.blue,
                    //     borderRadius: BorderRadius.circular(5.0)
                    //   ),
                    //   padding: const EdgeInsets.all(16.0),
                    //   child:  Padding(
                    //     padding: const EdgeInsets.only(left: 16.0),
                    //     child: 
                    //             OutlineButton(
                    //               color: Colors.white,
                    //               textColor: Colors.white,
                    //               borderSide: BorderSide(color: Colors.white),
                    //               child: Text("Telegram".toUpperCase()),
                    //               onPressed: () {},
                    //             ),
                    //   ),
                    // )
                  ],

                )
                
                
                

          ),
          
          Container(
                margin: EdgeInsets.fromLTRB(16.0, 0,16.0,16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                      Text("Hal Yang Sering Ditanyakan", style: Theme.of(context).textTheme.title,),
                      SizedBox(height: 10.0),
                      // Text("16, July 2020 By Andy Aba"),
                      // SizedBox(height: 10.0),
                      Divider(),
                      // SizedBox(height: 10.0,),
                      // Row(children: <Widget>[
                      //   Icon(Icons.favorite_border),
                      //   SizedBox(width: 5.0,),
                      //   Text("20.2k"),
                      //   SizedBox(width: 16.0,),
                      //   Icon(Icons.comment),
                      //   SizedBox(width: 5.0,),
                      //   Text("2.2k"),
                      // ],),
                      SizedBox(height: 10.0,),
                      Text("Siapa saja yang bisa bergabung di Komunitas Jago Bisnis? \n", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Siapapun Anda apapun latar belakang Anda selama masih punya kemauan untuk belajar dan untuk maju maka bisa bergabung di Komunitas Jago Bisnis. \n", textAlign: TextAlign.justify,),
                      SizedBox(height: 10.0),
                      Text("Bagaimana Proses Pembelajaran di Komunitas Jago Bisnis? \n", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Sistem belajar Jago Bisnis adalah secara offline dan online. Offline melalui seminar dan kopdar, online melalui grup whatsapp, channel telegram, channel youtube, webinar dan video course di website. \n", textAlign: TextAlign.justify,),
                      SizedBox(height: 10.0),
                      Text("Apakah ada jaminan saya bisa sukses menerapkan ilmu nya? \n", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Kesuksesan Anda di Jago Bisnis tergantung Anda sendiri, semakin Anda bersungguh -sungguh dan konsisten mempraktekan materinya maka akan semakin dekat dengan kesuksesan. \n", textAlign: TextAlign.justify,),
                      SizedBox(height: 10.0),
                      Text("Saya masih bekerja, Apakah saya bisa mengikuti pembelajaran ini? \n", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Sistem belajar di Jago Bisnis sangat fleksibel bisa disesuaikan dengan kesibukan Anda. \n", textAlign: TextAlign.justify,),
                      SizedBox(height: 10.0),
                      Text("Kemana Saya bisa menghubungi jika saya mengalami kendala? \n", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Anda bisa menghubungi Admin kami yang selalu siap membantu menyelesaikan kendala Anda. \n", textAlign: TextAlign.justify,),
                      SizedBox(height: 10.0),
                      
                  ],
                ),
              ),
          // _sliderNews(),
          // _buildTitledContainer("Sales",
          //       child: Container(
          //           height: 200, child: DonutPieChart.withSampleData())
          // ),
        
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Row(
          //     children: <Widget>[
          //       Expanded(
          //         flex: 2,
          //         child: _buildTile(
          //           color: Colors.pink,
          //           icon: Icons.portrait,
          //           title: "Omset Hari ini",
          //           data: "1200",
          //         ),
          //       ),
          //       const SizedBox(width: 16.0),
          //       Expanded(
          //         child: _buildTile(
          //           color: Colors.green,
          //           icon: Icons.portrait,
          //           title: "Profit",
          //           data: "857",
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 16.0),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Row(
          //     children: <Widget>[
          //       Expanded(
          //         child: _buildTile(
          //           color: Colors.blue,
          //           icon: Icons.favorite,
          //           title: "Unpaid",
          //           data: "864",
          //         ),
          //       ),
          //       const SizedBox(width: 16.0),
          //       Expanded(
          //         child: _buildTile(
          //           color: Colors.pink,
          //           icon: Icons.portrait,
          //           title: "Paid",
          //           data: "857",
          //         ),
          //       ),
          //       const SizedBox(width: 16.0),
          //       Expanded(
          //         child: _buildTile(
          //           color: Colors.blue,
          //           icon: Icons.favorite,
          //           title: "Shiped",
          //           data: "698",
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
  RoundedContainer _sliderNews(){
    return RoundedContainer(
            height: 270,
            borderRadius: BorderRadius.circular(0),
            color: color2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Featured News",
                  style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Swiper(
                    pagination: SwiperPagination(margin: const EdgeInsets.only()),
                    viewportFraction: 0.9,
                    itemCount: 4,
                    loop: false,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RoundedContainer(
                          borderRadius: BorderRadius.circular(4.0),
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "Apa itu jago bisnis",
                                  style: Theme.of(context).textTheme.title,
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: Colors.red,
                                  child: PNetworkImage(
                                    images[1],
                                    fit: BoxFit.cover,
                                    height: 210,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
  Container _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 32.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        color: Colors.blue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(
              prefs.getString('sessionNama').toString(),
              style: whiteText.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            trailing: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(prefs.getString('sessionGambar').toString()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              prefs.getString('sessionEmail').toString(),
              style: whiteText.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
                padding: const EdgeInsets.all(8.0),
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.orangeAccent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "FREE",
                      style:
                          whiteText.copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ],
                ),
              ),
          ),
         
        ],
      ),
    );
  }

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
          Text(
            data,
            style:
                whiteText.copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        ],
      ),
    );
  }


  

}



class DonutPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutPieChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutPieChart.withSampleData() {
    return new DonutPieChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 60,
            arcRendererDecorators: [new charts.ArcLabelDecorator()]));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, String>> _createSampleData() {
    final data = [
      new LinearSales("July", 100),
      new LinearSales("August", 75),
      new LinearSales("September", 25),
      new LinearSales("October", 5),
    ];

    return [
      new charts.Series<LinearSales, String>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.month,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final String month;
  final int sales;

  LinearSales(this.month, this.sales);
}
