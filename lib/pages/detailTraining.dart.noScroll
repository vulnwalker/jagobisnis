
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:jagobisnis/common/assets.dart';
import 'package:jagobisnis/common/config.dart';
// import 'package:jagobisnis/src/pages/food/recipe_details.dart';
import 'package:jagobisnis/common/widget/network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:jagobisnis/common/plugins/youtube_player.dart';


ConfigClass configClass = new ConfigClass();
class DetailTrainingPage extends StatefulWidget { 
 final String idMateri;
 final String judulMateri;
 final String deskripsiMateri;
 final String videoSource;
 final String thumbnail;
 final String durasi_video;
 final String youtubeSource;
 final String status;
 final String namaChapter;

  DetailTrainingPage(this.idMateri,this.judulMateri,this.deskripsiMateri,this.videoSource,this.thumbnail,this.durasi_video,this.youtubeSource,this.status,this.namaChapter) ;
  @override
  DetailTrainingPageState createState() => new DetailTrainingPageState();
}

class DetailTrainingPageState extends State<DetailTrainingPage> {
  static final String path = "lib/src/pages/food/recipe_single.dart";
  final Color icon = Color(0xffEF412D);
  // final Color color1 = Color(0xffCF3529);
  // final Color color2 = Color(0xffE1372F);
  // final Color color3 = Color(0xffFF6C1C);
    final Color color1 = Colors.blue;
  final Color color2 = Colors.blue.shade200;
  final Color color3 = Colors.blue.shade400;
  final Color color4 = Colors.blueGrey;
  final FijkPlayer player = FijkPlayer(
  );
//   YoutubePlayerController _controller = YoutubePlayerController(
//     initialVideoId: 'oZvheuVm_mw',
//     flags: YoutubePlayerFlags(
//         autoPlay: true,
//         mute: true,
//     ),
// );

//  String videoId = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=oZvheuVm_mw");
  @override
  void initState() {
    super.initState();
        player.setDataSource(
        widget.videoSource,
        autoPlay: true);
  }
  @override
  void dispose() {
    super.dispose();
    player.release();
  }
  @override
  Widget build(BuildContext context){
    

    return Scaffold(
      body:   Container(
        height: double.infinity,
        child:  Stack(
          children: <Widget>[
            Positioned(
              top: 260,
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
              top: 260,
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
            
            Positioned(
              top: 250,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                   
                    SizedBox(height: 40.0),
                    Text(widget.judulMateri.toUpperCase(), style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 30.0
                    ),),
                    SizedBox(height: 20.0),
                    Text(widget.deskripsiMateri, style: TextStyle(color: Colors.white70),),
                   
                  ],
                ),
                )
            ),
            Container(
              height: 290,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 30.0
                  )
                ]
              ),
              child: SizedBox(
                height: 260,
                child: 
                 FijkView(
                   player: player,
                   fit: FijkFit.fill
                   ),
                // PNetworkImage(widget.thumbnail, fit: BoxFit.fill,),
              ),
            ),
            // Positioned(
            //   top: 295,
            //   left: 20,
            //   child: CircleAvatar(
            //     backgroundColor: Colors.white,
            //     radius: 25,
            //     child: IconButton(
            //       color: icon,
            //       onPressed: (){},
            //       icon: Icon(Icons.play_arrow,)),
            //   ),
            // ),
            Positioned(
              top: 250,
              right: 20,
              child: RaisedButton(
                child: Text(widget.namaChapter.toUpperCase()),
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                onPressed: (){
                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (_) => RecipeDetailsPage()
                  // ));
                },
              ),
            ),
            Container(height: 70.0, child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            )),
          ],
        ),
      ),
    );
    
  }
}