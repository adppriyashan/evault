import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:identifyapp/Controllers/Documents/DocumentsController.dart';
import 'package:identifyapp/Controllers/Requests/RequestsController.dart';
import 'package:identifyapp/Models/Colors.dart';
import 'package:identifyapp/Models/Utils.dart';
import 'package:identifyapp/Views/Common/HomeDrawer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  RequestsController _requestsController = RequestsController();
  DocumentsController _documentsController = DocumentsController();

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
        child: FutureBuilder<Map<dynamic, List<dynamic>>>(
            future: _requestsController.getAllRequestsForMe(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  int _all = 0;
                  int valueCount = 0;

                  if (snapshot.data!.length > 0) {
                    _all = snapshot.data!['new']!.length +
                        snapshot.data!['old']!.length;

                    valueCount = (_all == 0)
                        ? 0
                        : ((snapshot.data!['new']!.length / _all) * 100)
                            .round();
                  }

                  return Column(
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
                                        MediaQuery.of(context).size.width,
                                        50.0))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 20.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (_scaffoldKey
                                              .currentState!.isDrawerOpen)
                                            _scaffoldKey.currentState!
                                                .openEndDrawer();
                                          else {
                                            _scaffoldKey.currentState!
                                                .openDrawer();
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
                                      (snapshot.data!.length > 0 &&
                                              snapshot.data!['new']!.length > 0)
                                          ? Icon(
                                              Icons.notification_important,
                                              color: UtilColors.whiteColor,
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  Utils.showToast(
                                                      'Requests Refreshed');
                                                });
                                              },
                                              child: Icon(
                                                Icons.refresh,
                                                color: UtilColors.whiteColor,
                                              ),
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
                                      color: UtilColors.blackColor
                                          .withOpacity(0.2),
                                      thicknessUnit: GaugeSizeUnit.factor,
                                    ),
                                    annotations: <GaugeAnnotation>[
                                      GaugeAnnotation(
                                          positionFactor: 0.1,
                                          angle: 90,
                                          widget: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'you have'.toUpperCase(),
                                                style: GoogleFonts.openSans(
                                                    color:
                                                        UtilColors.whiteColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                '${valueCount.toString()}%'
                                                    .toUpperCase(),
                                                style: GoogleFonts.openSans(
                                                    color:
                                                        UtilColors.whiteColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 35.0),
                                              ),
                                              Text(
                                                'digital wallet requests'
                                                    .toUpperCase(),
                                                style: GoogleFonts.openSans(
                                                    color:
                                                        UtilColors.whiteColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ))
                                    ],
                                    pointers: <GaugePointer>[
                                      RangePointer(
                                        value: valueCount.toDouble(),
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
                            child: (snapshot.data!.length > 0 &&
                                    snapshot.data!['new']!.length > 0)
                                ? ListView(
                                    children: snapshot.data!['new']!
                                        .map((item) => getNotification(item))
                                        .toList())
                                : Center(
                                    child: Text(
                                        'No Digital Wallet Requests'
                                            .toUpperCase(),
                                        style: GoogleFonts.openSans(
                                            color: UtilColors.primaryColor,
                                            fontWeight: FontWeight.bold)),
                                  ),
                          ))
                    ],
                  );
                } else {
                  return Center(
                    child: Text('No Requests Found'),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: UtilColors.primaryColor,
                  ),
                );
              }
            }),
      ),
    ));
  }

  Widget getNotification(data) {
    return Container(
      margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
      decoration: BoxDecoration(
          border: Border.all(color: UtilColors.secondaryColor),
          borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications,
              color: UtilColors.primaryColor,
            )
          ],
        ),
        title: Text(
          (Utils.getDocumentName(data['type']).length < 18)
              ? Utils.getDocumentName(data['type']).toUpperCase()
              : Utils.getDocumentName(data['type'])
                      .toUpperCase()
                      .substring(0, 18) +
                  '..',
          style: GoogleFonts.openSans(
              color: UtilColors.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 15.0),
        ),
        subtitle: Text(
          'By ${data['name']}'.toUpperCase(),
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
          onPressed: (int index) async {
            Utils.showLoader(context);
            if (index == 0) {
              await _requestsController
                  .checkForDocumentExist(Utils.profileUser.uid, data['type'])
                  .then((value) async {
                if (value == true) {
                  await _requestsController
                      .approveRequest(data['id'], data['by'])
                      .then((value) => setState(() {
                            Utils.showToast('Request Approved');
                          }));
                } else {
                  Utils.showToast(
                      'Requested Documents Not Found. Please Insert First');
                }
              });
            } else {
              await _requestsController
                  .rejectRequest(data['id'], data['by'])
                  .then((value) => setState(() {
                        Utils.showToast('Request Rejected');
                      }));
            }
            Utils.hideLoaderCurrrent(context);
          },
          isSelected: [true, false],
        ),
      ),
    );
  }
}
