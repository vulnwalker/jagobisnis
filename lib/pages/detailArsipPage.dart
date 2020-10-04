
// import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:jagobisnis/common/assets.dart';
import 'package:jagobisnis/common/config.dart';
import 'package:jagobisnis/common/widget/network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_admob/firebase_admob.dart';


ConfigClass configClass = new ConfigClass();
class DetailArsipPage extends StatefulWidget { 
 final String idMateri;
 final String tanggal;
 final String judulMateri;
 final String deskripsiMateri;
 final String pemateri;
 final String status;

  DetailArsipPage(this.idMateri,this.tanggal,this.judulMateri,this.deskripsiMateri,this.pemateri,this.status) ;
  @override
  DetailArsipPageState createState() => new DetailArsipPageState();
}

class DetailArsipPageState extends State<DetailArsipPage> {
  static final String path = "lib/src/pages/food/recipe_single.dart";
  final Color icon = Color(0xffEF412D);
  // final Color color1 = Color(0xffCF3529);
  // final Color color2 = Color(0xffE1372F);
  // final Color color3 = Color(0xffFF6C1C);
    final Color color1 = Colors.blue;
  final Color color2 = Colors.blue.shade200;
  final Color color3 = Colors.blue.shade400;
  final Color color4 = Colors.blueGrey;
  // final FijkPlayer player = FijkPlayer(
  // );


  InterstitialAd interstitialAd;
  InterstitialAd buildInterstitial() {
    return InterstitialAd(
        adUnitId: "ca-app-pub-1281561182496486/1296342630",
        // adUnitId: InterstitialAd.testAdUnitId,
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.failedToLoad) {
            interstitialAd..load();
          } else if (event == MobileAdEvent.closed) {
            // interstitialAd = buildInterstitial()..load();
          }else if (event == MobileAdEvent.loaded) {
            interstitialAd.show();
          }
          print(event);
        });
  }


  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-1281561182496486~7970573954");
    interstitialAd = buildInterstitial()..load();
    super.initState();

  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    final ScrollController _scrollController = ScrollController();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color2, color3],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                  )
                ),
              )
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 150,
              bottom: 80,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: color1,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50.0)
                  )
                ),
              )
            ),
            Scrollbar(
              // isAlwaysShown: true,
              controller: _scrollController,
              child: ListView(
                children: <Widget>[
                  // Container(
                  //   height: 240,
                  //   alignment: Alignment.topCenter,
                  //   decoration: BoxDecoration(
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.black38,
                  //         blurRadius: 30.0
                  //       )
                  //     ]
                  //   ),
                  //   child: SizedBox(
                  //     height: 260,
                  //     child: FittedBox(
                  //     fit: BoxFit.fill,
                  //     child:
                  //       YoutubePlayer(
                  //         controller: _controller,
                  //         showVideoProgressIndicator: true,
                  //         onReady: () {
                  //           print('Player is ready. ');
                  //         },
                  //       ),
                  //       // FijkView(
                  //       //   player: player,
                  //       //   fit: FijkFit.fill
                  //       // ),
                  //     )
                  //   ),
                  // ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16,0,16,0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(170,0,0,10),
                          child: RaisedButton(
                            child: Text(widget.pemateri.toUpperCase()),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                            onPressed: (){
                              // Navigator.push(context, MaterialPageRoute(
                              //   builder: (_) => RecipeDetailsPage()
                              // ));
                            },
                          ),
                        ),
                        Text(widget.judulMateri.toUpperCase(), style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 30.0
                        ),),
                        SizedBox(height: 20.0),
                        Text(widget.deskripsiMateri, style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0
                          ),
                        )
                      ],
                    ),
                  )

                ]
              )
            )

        ],
      ),
    );
    
    
  }
}