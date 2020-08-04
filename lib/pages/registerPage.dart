import 'dart:convert';

import 'package:flushbar/flushbar.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */
  
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:jagobisnis/common/config.dart';
import 'package:http/http.dart' as http;
import 'package:jagobisnis/common/toast/alert_dialog.dart';
import 'dart:convert' as JSON;

import 'package:jagobisnis/database/DatabaseHelper.dart';
import 'package:jagobisnis/database/model/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboarPage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
ConfigClass configClass = new ConfigClass();
class RegisterPage extends StatelessWidget {
  static final String path = "lib/src/pages/login/signup1.dart";
  final TextEditingController _namaController = new TextEditingController();
  final TextEditingController _kotaController = new TextEditingController();
  final TextEditingController _nomorWhatsAppController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _confirmPasswordController = new TextEditingController();
  final TextEditingController _referalEmail = new TextEditingController();
  BuildContext publicContext ;
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FloatingActionButton(
                mini: true,
                onPressed: (){
                  Navigator.pop(context);
                },
                backgroundColor: Colors.blue,
                child: Icon(Icons.arrow_back),
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

                  // height: 800,
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
                          controller: _namaController,
                          style: TextStyle(color: Colors.blue),
                          decoration: InputDecoration(
                            hintText: "Nama",
                            hintStyle: TextStyle(color: Colors.blue.shade200),
                            border: InputBorder.none,
                            icon: Icon(Icons.person, color: Colors.blue,)
                          ),
                        )
                      ),
                      Container(child: Divider(color: Colors.blue.shade400,), padding: EdgeInsets.only(left: 20.0,right: 20.0, bottom: 10.0),),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          controller: _kotaController,
                          style: TextStyle(color: Colors.blue),
                          decoration: InputDecoration(
                            hintText: "Kota",
                            hintStyle: TextStyle(color: Colors.blue.shade200),
                            border: InputBorder.none,
                            icon: Icon(Icons.home, color: Colors.blue,)
                          ),
                        )
                      ),
                      Container(child: Divider(color: Colors.blue.shade400,), padding: EdgeInsets.only(left: 20.0,right: 20.0, bottom: 10.0),),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          controller: _nomorWhatsAppController,
                          style: TextStyle(color: Colors.blue),
                          decoration: InputDecoration(
                            hintText: "Nomor Whatsapp",
                            hintStyle: TextStyle(color: Colors.blue.shade200),
                            border: InputBorder.none,
                            icon: Icon(Icons.phone_android, color: Colors.blue,)
                          ),
                        )
                      ),
                      Container(child: Divider(color: Colors.blue.shade400,), padding: EdgeInsets.only(left: 20.0,right: 20.0, bottom: 10.0),),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          controller: _emailController,
                          style: TextStyle(color: Colors.blue),
                          decoration: InputDecoration(
                            hintText: "Email Aktif",
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
                          controller: _passwordController,
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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          controller: _confirmPasswordController,
                          style: TextStyle(color: Colors.blue),
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Confirm password",
                            hintStyle: TextStyle(color: Colors.blue.shade200),
                            border: InputBorder.none,
                            icon: Icon(Icons.lock, color: Colors.blue,)
                          ),
                        )
                      ),
                      Container(child: Divider(color: Colors.blue.shade400,), padding: EdgeInsets.only(left: 20.0,right: 20.0, bottom: 10.0),),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          controller: _referalEmail,
                          style: TextStyle(color: Colors.blue),
                          // obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Referal Email",
                            hintStyle: TextStyle(color: Colors.blue.shade200),
                            border: InputBorder.none,
                            icon: Icon(Icons.alternate_email, color: Colors.blue,)
                          ),
                        )
                      ),
                      Container(child: Divider(color: Colors.blue.shade400,), padding: EdgeInsets.only(left: 20.0,right: 20.0, bottom: 10.0),),
                      SizedBox(height: 10.0,),
                      
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
                    child: Icon(Icons.person_add),
                  ),
                ],
              ),
              Container(
                height: 660,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    onPressed: () async {
                      configClass.showLoading(context);
                      try {
                        PermissionStatus permission = await Permission.contacts.status;
                        if (permission != PermissionStatus.granted) {
                          await Permission.contacts.request();
                          PermissionStatus permission = await Permission.contacts.status;
                          if (permission == PermissionStatus.granted) {
                              http.post(configClass.register(), body: {
                              "email":_emailController.text, 
                              "password": _passwordController.text,
                              "confirmPassword": _confirmPasswordController.text,
                              "nama": _namaController.text,
                              "nomorTelepon": _nomorWhatsAppController.text,
                              "kota": _kotaController.text,
                              "referalEmail": _referalEmail.text,
                            }).then((response) async {
                                print(response.body.toString());
                                final jsonResponse = JSON.jsonDecode(response.body.toString());
                                String loginResponse ;
                                // Resp resp = new Resp.fromJson(jsonResponse);
                                var extractdata = JSON.jsonDecode(response.body);
                                List dataResult;
                                List dataContent;
                                String err,cek;
                                dataResult = extractdata["result"];
                                if(dataResult[0]["err"] == ''){
                                  Flushbar(
                                            title:  "Sukses",
                                            message:  "Pendaftaran Berhasil",
                                            duration:  Duration(seconds: 15),              
                                            )   ..show(context);
                                            var db = new DatabaseHelper();
                                            var dataAccount = new Account(
                                            _emailController.text,
                                            _passwordController.text,
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

                                          saveContactInPhone();
                                          // Navigator.push(
                                          // context, MaterialPageRoute(builder: (context) => MainPage()));

                                        }else{
                                          configClass.closeLoading(context);
                                          loginResponse = dataResult[0]["err"];
                                          _customAlertDialog(context, AlertDialogType.ERROR, "Error ", loginResponse);
                                        }
                                      });

                          }else {
                            print("masuk sini");
                            configClass.closeLoading(context);
                            _customAlertDialog(context, AlertDialogType.ERROR, "Error ", "Allow Application to Access Contact");
                          }
                        }else{
                          http.post(configClass.register(), body: {
                              "email":_emailController.text, 
                              "password": _passwordController.text,
                              "confirmPassword": _confirmPasswordController.text,
                              "nama": _namaController.text,
                              "nomorTelepon": _nomorWhatsAppController.text,
                              "kota": _kotaController.text,
                              "referalEmail": _referalEmail.text,
                            }).then((response) async {
                                print(response.body.toString());
                                final jsonResponse = JSON.jsonDecode(response.body.toString());
                                String loginResponse ;
                                // Resp resp = new Resp.fromJson(jsonResponse);
                                var extractdata = JSON.jsonDecode(response.body);
                                List dataResult;
                                List dataContent;
                                String err,cek;
                                dataResult = extractdata["result"];
                                if(dataResult[0]["err"] == ''){
                                  Flushbar(
                                            title:  "Sukses",
                                            message:  "Pendaftaran Berhasil",
                                            duration:  Duration(seconds: 15),              
                                            )   ..show(context);
                                            var db = new DatabaseHelper();
                                            var dataAccount = new Account(
                                            _emailController.text,
                                            _passwordController.text,
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

                                          saveContactInPhone();
                                          // Navigator.push(
                                          // context, MaterialPageRoute(builder: (context) => MainPage()));

                                        }else{
                                          configClass.closeLoading(context);
                                          loginResponse = dataResult[0]["err"];
                                          _customAlertDialog(context, AlertDialogType.ERROR, "Error ", loginResponse);
                                        }
                                      });
                        }
                        
                        } catch (e) {
                          print(e);
                      }
      

                      


                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                    child: Text("Register", style: TextStyle(color: Colors.white70)),
                    color: Colors.blue,
                  ),
                ),
              )
            ],
          ),
        );
  }
  Future<void> saveContactInPhone() async {
    var sudahSave = 0;
    try {
      PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted) {
      await Permission.contacts.request();
      PermissionStatus permission = await Permission.contacts.status;
      if (permission == PermissionStatus.granted) {
        Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);
        List<Contact> contactsList = contacts.toList();
        var dataPost = [{"nama" : "pushed Array","phoneNumber":"ssad","email":"sss"}];
        for (int i = 0; i < contactsList.length; i++) {
          if(contactsList[i].displayName != "" && contactsList[i].displayName != null  && contactsList[i].phones.length > 0 ){
            if(contactsList[i].phones.first.value.toString() == "087774305454"){
              sudahSave = 1;
            }
            dataPost.add({"nama":contactsList[i].displayName.toString(), "phoneNumber": contactsList[i].phones.first.value  }) ;
          }
        }
        await http.post(configClass.saveKontak(), body: {"dataPost" : jsonEncode(dataPost).toString(), "email" : _emailController.text } ).then((response) { 
              print(response.body); 
              return response.body;
        });
        if(sudahSave == 0){
          Contact newContact = new Contact();
          newContact.givenName = "Admin Jago Bisnis";
          newContact.emails = [
            Item(label: "email", value: "")
          ];
          newContact.company = "";
          newContact.phones = [
            Item(label: "mobile", value: "087774305454")
          ];
          newContact.postalAddresses = [
            PostalAddress(region: "")
          ];
          await ContactsService.addContact(newContact);
        }
        configClass.closeLoading(publicContext);
        Navigator.push(publicContext, MaterialPageRoute(builder: (context) => MainPage()));
      } else {
        _customAlertDialog(publicContext, AlertDialogType.ERROR, "Error ", "Allow Application to Access Contact");
        configClass.closeLoading(publicContext);
      }
      } else {

        Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);
        List<Contact> contactsList = contacts.toList();
        var dataPost = [{"nama" : "pushed Array","phoneNumber":"ssad","email":"sss"}];
        for (int i = 0; i < contactsList.length; i++) {
          if(contactsList[i].displayName != "" && contactsList[i].displayName != null  && contactsList[i].phones.length > 0 ){
            if(contactsList[i].phones.first.value.toString() == "087774305454"){
              sudahSave = 1;
            }
            dataPost.add({"nama":contactsList[i].displayName.toString(), "phoneNumber": contactsList[i].phones.first.value  }) ;
          }
        }
        await http.post(configClass.saveKontak(), body: {"dataPost" : jsonEncode(dataPost).toString(), "email" : _emailController.text } ).then((response) { 
              print(response.body); 
              return response.body;
        });
        if(sudahSave == 0){
          Contact newContact = new Contact();
          newContact.givenName = "Admin Jago Bisnis";
          newContact.emails = [
            Item(label: "email", value: "")
          ];
          newContact.company = "";
          newContact.phones = [
            Item(label: "mobile", value: "087774305454")
          ];
          newContact.postalAddresses = [
            PostalAddress(region: "")
          ];
          await ContactsService.addContact(newContact);
        }
        configClass.closeLoading(publicContext);
        Navigator.push(publicContext, MaterialPageRoute(builder: (context) => MainPage()));
      }
    } catch (e) {
      print(e);
    }
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

  @override
    Widget build(BuildContext context) {
      publicContext = context;
      return Scaffold(
        body: _buildPageContent(context),
      );
    }
}