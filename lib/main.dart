import 'package:jagobisnis/common/CheckRoute.dart';
import 'package:jagobisnis/pages/dashboarPage.dart';

import 'package:jagobisnis/pages/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Saudagar Kaya',
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
        // "register": (BuildContext context) => SignUpPage(),
        // "profile": (BuildContext context) => Profile(),
        // "membership": (BuildContext context) => MemberShip(),
        // "welcomePage": (BuildContext context) => WelcomePage(),
        // "produkPage": (BuildContext context) => ProdukPage(),
        // "copyWritingPage": (BuildContext context) => CopyWriting(),
        // "leadPage": (BuildContext context) => LeadPage(),
        // "kotak": (BuildContext context) => ShoppingWidgets(),
        // "cartPage": (BuildContext context) => CartPage(),
        // "checkoutPage": (BuildContext context) => CheckoutPage(),
        // "invoicePage": (BuildContext context) => InvoicePage(),
        // "trainingPage": (BuildContext context) => TrainingPage(),
      },
    );
  }
}
