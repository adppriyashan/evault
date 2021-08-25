import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:identifyapp/Models/Colors.dart';
import 'package:identifyapp/Views/Documents/New-Document.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Documents extends StatefulWidget {
  Documents({Key? key}) : super(key: key);

  @override
  _DocumentsState createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
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
                      'My Documents'.toUpperCase(),
                      style: GoogleFonts.openSans(
                          color: UtilColors.whiteColor,
                          fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (_) => NewDocument(),
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
                  getNotification(
                      "https://5.imimg.com/data5/NH/AF/AC/SELLER-81442233/birth-certificate-500x500.png",
                      'Birth Certificate'),
                  getNotification(
                      "https://upload.wikimedia.org/wikipedia/commons/b/b3/Polish_id_card_2019.jpg",
                      'National Identity Card'),
                  getNotification(
                      "https://upload.wikimedia.org/wikipedia/commons/d/dd/Sri_Lankan_Passport.jpg",
                      'Passport'),
                ],
              ),
            ))
          ],
        ),
      ),
    ));
  }

  getNotification(String imgUrl, String title) {
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
              backgroundImage: NetworkImage(imgUrl),
            )
          ],
        ),
        title: Text(
          title.toUpperCase(),
          style: GoogleFonts.openSans(
              color: UtilColors.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 13.0),
        ),
        subtitle: Text(
          '24th of January'.toUpperCase(),
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
              Icons.edit,
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
