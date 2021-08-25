import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:identifyapp/Controllers/Common/SplashScreenController.dart';
import 'package:identifyapp/Models/Colors.dart';
import 'package:identifyapp/Models/Images.dart';
import 'package:identifyapp/Models/Strings.dart';
import 'package:identifyapp/Models/Utils.dart';
import 'package:identifyapp/Views/Auth/Login.dart';
import 'package:identifyapp/Views/Common/Home.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: UtilColors.primaryColor,
        systemNavigationBarColor: UtilColors.secondaryColor,
        systemNavigationBarDividerColor: UtilColors.primaryColor));

    startApp();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Utils.displaySize = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: Utils.displaySize.width * 0.3,
                      width: Utils.displaySize.width * 0.3,
                      child: Image.asset(UtilImages.logoPNG)),
                  Text(
                    UtilStrings.appTitle,
                    style: GoogleFonts.openSans(
                        color: UtilColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 35.0),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  UtilStrings.splashScreen,
                  style: GoogleFonts.openSans(
                      color: UtilColors.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  void startApp() async {
    await SplashScreenController().checkAuth().then((value) {
      _timer = Timer.periodic(
          Duration(seconds: 3),
          (t) => Navigator.of(context, rootNavigator: true).pushReplacement(
                MaterialPageRoute(
                    builder: (_) => (value == true) ? Home() : Login()),
              ));
    });
  }
}
