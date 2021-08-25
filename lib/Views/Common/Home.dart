import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:identifyapp/Models/Colors.dart';
import 'package:identifyapp/Views/Common/HomeDrawer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: HomeDrawer(
          selection: 1,
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        tileMode: TileMode.decal,
                        end: Alignment.bottomLeft,
                        colors: [
                          UtilColors.primaryColor,
                          UtilColors.secondaryColor,
                        ],
                      ),
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              MediaQuery.of(context).size.width, 50.0))),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (_scaffoldKey.currentState!.isDrawerOpen)
                                  _scaffoldKey.currentState!.openEndDrawer();
                                else {
                                  _scaffoldKey.currentState!.openDrawer();
                                }
                              },
                              child: Icon(
                                Icons.menu_sharp,
                                color: UtilColors.whiteColor,
                              ),
                            ),
                            Text(
                              'Welcome back !'.toUpperCase(),
                              style: GoogleFonts.openSans(
                                  color: UtilColors.whiteColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            Icon(
                              Icons.notification_important,
                              color: UtilColors.whiteColor,
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                          child: SfRadialGauge(axes: <RadialAxis>[
                        RadialAxis(
                          minimum: 0,
                          maximum: 100,
                          showLabels: false,
                          showTicks: false,
                          axisLineStyle: AxisLineStyle(
                            thickness: 0.2,
                            cornerStyle: CornerStyle.bothCurve,
                            color: UtilColors.blackColor.withOpacity(0.2),
                            thicknessUnit: GaugeSizeUnit.factor,
                          ),
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                positionFactor: 0.1,
                                angle: 90,
                                widget: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'you have'.toUpperCase(),
                                      style: GoogleFonts.openSans(
                                          color: UtilColors.whiteColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '21%'.toUpperCase(),
                                      style: GoogleFonts.openSans(
                                          color: UtilColors.whiteColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 35.0),
                                    ),
                                    Text(
                                      'digital wallet requests'.toUpperCase(),
                                      style: GoogleFonts.openSans(
                                          color: UtilColors.whiteColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ))
                          ],
                          pointers: <GaugePointer>[
                            RangePointer(
                              value: 21,
                              color: UtilColors.blackColor,
                              cornerStyle: CornerStyle.bothCurve,
                              width: 0.2,
                              sizeUnit: GaugeSizeUnit.factor,
                            )
                          ],
                        )
                      ]))
                    ],
                  ),
                )),
            Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: ListView(
                    children: [
                      getNotification(),
                      getNotification(),
                      getNotification(),
                      getNotification(),
                      getNotification()
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
          'By Pasindu Priyashan'.toUpperCase(),
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
              Icons.check,
              size: 20.0,
            ),
            Icon(
              Icons.close,
              size: 20.0,
            ),
          ],
          onPressed: (int index) {
            setState(() {});
          },
          isSelected: [true, false],
        ),
      ),
    );
  }
}
