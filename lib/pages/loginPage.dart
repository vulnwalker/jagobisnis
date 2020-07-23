
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jagobisnis/common/config.dart';
import 'package:jagobisnis/database/DatabaseHelper.dart';
import 'package:jagobisnis/database/model/account.dart';
import 'package:jagobisnis/pages/registerPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

import 'package:shared_preferences/shared_preferences.dart';

import 'dashboarPage.dart';

// import 'package:jagobisnis/src/pages/login/signup1.dart';
ConfigClass configClass = new ConfigClass();

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();
  String deviceUniqueKey = "";

  Widget _buildPageContent(BuildContext context) {
    return Container(
      color: Colors.blue.shade100,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 30.0,),
          CircleAvatar(child: Image.network("http://jagobisnis.info/wp-content/uploads/2020/06/cropped-kl.png"), maxRadius: 50, backgroundColor: Colors.transparent,),
          SizedBox(height: 20.0,),
          _buildLoginForm(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => RegisterPage()
                  ));
                },
                child: Text("Register", style: TextStyle(color: Colors.blue, fontSize: 18.0)),
              )
            ],
          )
        ],
      ),
    );
  }

  Container _buildLoginForm(context) {
    return Container(
          padding: EdgeInsets.all(20.0),
          child: Stack(
            children: <Widget>[
              ClipPath(
                clipper: RoundedDiagonalPathClipper(),
                child: Container(
                  height: 400,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 90.0,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          controller: this._emailController,
                          style: TextStyle(color: Colors.blue),
                          decoration: InputDecoration(
                            hintText: "Email address",
                            hintStyle: TextStyle(color: Colors.blue.shade200),
                            border: InputBorder.none,
                            icon: Icon(Icons.email, color: Colors.blue,)
                          ),
                        )
                      ),
                      Container(child: Divider(color: Colors.blue.shade400,), padding: EdgeInsets.only(left: 20.0,right: 20.0, bottom: 10.0),),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          controller: this._passController,
                          style: TextStyle(color: Colors.blue),
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.blue.shade200),
                            border: InputBorder.none,
                            icon: Icon(Icons.lock, color: Colors.blue,)
                          ),
                        )
                      ),
                      Container(child: Divider(color: Colors.blue.shade400,), padding: EdgeInsets.only(left: 20.0,right: 20.0, bottom: 10.0),),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: <Widget>[
                      //     Container(padding: EdgeInsets.only(right: 20.0),
                      //       child: Text("Forgot Password",
                      //         style: TextStyle(color: Colors.black45),
                      //       )
                      //     )
                      //   ],
                      // ),
                      // SizedBox(height: 10.0,),
                      
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.blue.shade600,
                    child: Icon(Icons.person),
                  ),
                ],
              ),
              Container(
                height: 420,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    onPressed: (){
                      configClass.showLoading(context);
                      http.post(configClass.auth(), body: {"email":_emailController.text, "password": _passController.text, "deviceCode": deviceUniqueKey}).then((response) async {
                        print(response.body);
                        configClass.closeLoading(context);
                    
                        final jsonResponse = JSON.jsonDecode(response.body.toString());
                        String loginResponse ;
                        // Resp resp = new Resp.fromJson(jsonResponse);
                        var extractdata = JSON.jsonDecode(response.body);
                        List dataResult;
                        List dataContent;
                        String err,cek;
                        dataResult = extractdata["result"];
                        // err = dataResult[0]["err"];
                        // cek = dataResult[0]["cek"];
                        // dataContent = dataResult[0]["content"];
                        // Flushbar(
                        //             title:  "Response",
                        //             message:  dataResult[0]["content"]["nama"],
                        //             duration:  Duration(seconds: 15),              
                        //             )   ..show(context);

                        if(dataResult[0]["err"] == ''){
                          
                          var db = new DatabaseHelper();

                          
                          var dataAccount = new Account(
                            _emailController.text,
                            _passController.text,
                            dataResult[0]["content"]["nama"],
                            dataResult[0]["content"]["nomor_telepon"],
                            int.tryParse(dataResult[0]["content"]["jumlah_barang"]),
                            dataResult[0]["content"]["nama_bank"],
                            dataResult[0]["content"]["nomor_rekening"],
                            dataResult[0]["content"]["nama_rekening"],
                            dataResult[0]["content"]["lisensi"],
                            int.tryParse(dataResult[0]["content"]["profit"]),
                            1,
                            dataResult[0]["content"]["kota"],
                          );
                          db.saveAccount(dataAccount);
                          print("Welcome "+ dataResult[0]["content"]["nama"].toString());
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString('sessionEmail',_emailController.text);
                          prefs.setString('sessionNama',dataResult[0]["content"]["nama"]);
                          prefs.setString('sessionGambar',dataResult[0]["content"]["foto"]);
                          Navigator.push(
                          context, MaterialPageRoute(builder: (context) => MainPage()));

                        }else{
                          loginResponse = dataResult[0]["err"];
                          AlertDialog dialog = new AlertDialog(
                            content: new Text(loginResponse)
                          );
                          showDialog(context: context,child: dialog);
                        }

                      });

                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                    child: Text("Login", style: TextStyle(color: Colors.white70)),
                    color: Colors.blue,
                  ),
                ),
              )
            ],
          ),
        );
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: _buildPageContent(context),
      );
    }
}