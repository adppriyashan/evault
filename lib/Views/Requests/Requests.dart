import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:identifyapp/Models/Colors.dart';
import 'package:identifyapp/Views/Requests/New-Request.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Requests extends StatefulWidget {
  Requests({Key? key}) : super(key: key);

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              color: UtilColors.primaryColor,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: UtilColors.whiteColor,
                      ),
                    ),
                    Text(
                      'Requests'.toUpperCase(),
                      style: GoogleFonts.openSans(
                          color: UtilColors.whiteColor,
                          fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (_) => NewRequest(),
                        ).then((onValue) {});
                      },
                      child: Icon(
                        Icons.add,
                        color: UtilColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
                child: Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: ListView(
                children: [
                  getNotification(),
                  getNotification(),
                  getNotification(),
                  getNotification(),
                  getNotification(),
                  getNotification(),
                  getNotification(),
                  getNotification(),
                  getNotification(),
                  getNotification(),
                ],
              ),
            ))
          ],
        ),
      ),
    ));
  }

  getNotification() {
    return Container(
      margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
      decoration: BoxDecoration(
          border: Border.all(color: UtilColors.secondaryColor),
          borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTt-JmDfLz7ErRiTZ9vIme55A9JGQqdx8qJ_xQ_lB2UIqGAFELpsKQQ8xuTSrlqrly-tSQ&usqp=CAU"),
            )
          ],
        ),
        title: Text(
          'Birth Certificate'.toUpperCase(),
          style: GoogleFonts.openSans(
              color: UtilColors.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 15.0),
        ),
        subtitle: Text(
          'From Pasindu Priyashan'.toUpperCase(),
          style: GoogleFonts.openSans(
              color: UtilColors.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 10.0),
        ),
        trailing: ToggleButtons(
          color: UtilColors.primaryColor,
          fillColor: UtilColors.primaryColor,
          selectedColor: UtilColors.whiteColor,
          children: <Widget>[
            Icon(
              Icons.visibility,
              size: 20.0,
            ),
            Icon(
              Icons.delete,
              size: 20.0,
            ),
          ],
          onPressed: (int index) {
            setState(() {});
          },
          isSelected: [false, false],
        ),
      ),
    );
  }
}
