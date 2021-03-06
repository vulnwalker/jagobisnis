import 'package:jagobisnis/common/CheckRoute.dart';
import 'package:jagobisnis/pages/arsipPage.dart';
import 'package:jagobisnis/pages/dashboarPage.dart';
import 'package:jagobisnis/pages/leadPage.dart';

import 'package:jagobisnis/pages/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jagobisnis/pages/memberShipPage.dart';
import 'package:jagobisnis/pages/profilePage.dart';
import 'package:jagobisnis/pages/trainingPage.dart';
import 'package:jagobisnis/pages/updateProfilePage.dart';
import 'package:jagobisnis/pages/youtube.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Jago Bisnis',
      theme: ThemeData(
         primarySwatch: Colors.blue,
         textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
           body1: GoogleFonts.montserrat(textStyle: textTheme.body1),
         ),
      ),
      debugShowCheckedModeBanner: false,
      home: CheckRoute(),
      routes: <String, WidgetBuilder>{
        "login": (BuildContext context) => LoginPage(),
        "dashboardPage": (BuildContext context) => MainPage(),
        "profile": (BuildContext context) => Profile(),
        "updateProfile": (BuildContext context) => UpdateProfile(),
        "membership": (BuildContext context) => MemberShip(),
        "trainingPage": (BuildContext context) => TrainingPage(),
        "leadPage": (BuildContext context) => LeadPage(),
        "arsipPage": (BuildContext context) => ArsipPage(),
        "youtube": (BuildContext context) => VideoScreen(),

        // "welcomePage": (BuildContext context) => WelcomePage(),
        // "produkPage": (BuildContext context) => ProdukPage(),
        // "copyWritingPage": (BuildContext context) => CopyWriting(),
        // "kotak": (BuildContext context) => ShoppingWidgets(),
        // "cartPage": (BuildContext context) => CartPage(),
        // "checkoutPage": (BuildContext context) => CheckoutPage(),
        // "invoicePage": (BuildContext context) => InvoicePage(),
      },
    );
  }
}
