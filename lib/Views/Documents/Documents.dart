import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:identifyapp/Controllers/Documents/DocumentsController.dart';
import 'package:identifyapp/Models/Colors.dart';
import 'package:identifyapp/Models/Utils.dart';
import 'package:identifyapp/Views/Documents/New-Document.dart';

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

  DocumentsController _documentsController = DocumentsController();

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
                  future: _documentsController.getDocuments(),
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
    String title = "";
    String subtitle = "";
    late String _image;

    Utils.docs.forEach((element) {
      if (element['id'] == data['type']) {
        title = element['name'];
        if (element['hasNumber'] == true) {
          subtitle = data['data'];
        }
      }
    });

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
              backgroundImage: MemoryImage(base64Decode(data['image1'])),
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
          subtitle.toUpperCase(),
          style: GoogleFonts.openSans(
              color: UtilColors.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 10.0),
        ),
        trailing: GestureDetector(
          onTap: () async {
            try {
              Utils.showLoader(context);
              await _documentsController.deleteDocument(data['id']);
              Utils.hideLoader();
              setState(() {});
            } catch (e) {
              Utils.showToast('Something Wrong');
            }
          },
          child: Icon(Icons.delete, size: 20.0, color: UtilColors.redColor),
        ),
      ),
    );
  }
}
