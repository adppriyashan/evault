import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:identifyapp/Controllers/Requests/RequestsController.dart';
import 'package:identifyapp/Models/Colors.dart';
import 'package:identifyapp/Models/Utils.dart';
import 'package:identifyapp/Views/Common/ImageView.dart';
import 'package:identifyapp/Views/Requests/New-Request.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Requests extends StatefulWidget {
  Requests({Key? key}) : super(key: key);

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  RequestsController _requestController = RequestsController();

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
                        ).then((onValue) {
                          setState(() {});
                        });
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
              child: FutureBuilder<List<dynamic>>(
                  future: _requestController.getNewRequestsFormMe(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data!.length > 0) {
                        return ListView(
                            children: snapshot.data!
                                .map((data) => getNotification(data))
                                .toList());
                      } else {
                        return Center(
                          child: Text('No Documents Found'),
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ))
          ],
        ),
      ),
    ));
  }

  Widget getNotification(data) {
    Color _color = UtilColors.primaryColor;

    if (data['status'] == 1) {
      _color = UtilColors.greyColor;
    } else if (data['status'] == 2) {
      _color = UtilColors.greenColor;
    } else {
      _color = UtilColors.redColor;
    }

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
              color: _color,
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
          data['email'],
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
              color: (data['status'] == 2)
                  ? UtilColors.primaryColor
                  : UtilColors.greyColor,
            ),
            Icon(
              Icons.delete,
              size: 20.0,
              color: UtilColors.redColor,
            ),
          ],
          onPressed: (int index) async {
            if (index == 0) {
              if (data['status'] == 2) {
                Utils.showLoader(context);
                await _requestController
                    .getDocument(data['to'].toString(), data['id'].toString(),
                        data['type'].toString())
                    .then((value) {
                  Utils.hideLoaderCurrrent(context);
                  if (value.length > 0) {
                    List<Map<String, dynamic>> images = [];

                    images
                        .add({'id': 1, 'image': value.values.first['image1']});

                    if (value.values.first['image2'].toString().isNotEmpty) {
                      images.add(
                          {'id': 2, 'image': value.values.first['image2']});
                    }

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ImageView(
                                  galleryItems: images,
                                  title: (value.values.first['data'] != null)
                                      ? value.values.first['data']
                                      : Utils.getDocumentName(
                                          value.values.first['type']),
                                )));
                  } else {
                    Utils.showToast('Document Deleted By User. Please Retry.');
                  }
                });
              }
            } else {
              await _requestController
                  .removeRequest(data['to'], data['id'])
                  .then((value) {
                setState(() {
                  Utils.showToast("Request Removed");
                });
              });
            }
          },
          isSelected: [false, false],
        ),
      ),
    );
  }
}
