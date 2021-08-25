import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:identifyapp/Models/Colors.dart';
import 'package:identifyapp/Models/Images.dart';
import 'package:identifyapp/Models/Utils.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class NewRequest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewRequestState();
}

class NewRequestState extends State<NewRequest> {
  static List<Map<String, dynamic>> _docs = [
    {"id": 1, "name": "National Identity Card"},
    {"id": 2, "name": "Birth Certificate"},
    {"id": 3, "name": "Passport"},
    {"id": 4, "name": "Covid Vaccinated Report"},
  ];

  final _documents = _docs
      .map((_doc) => MultiSelectItem<dynamic>(_doc['id'], _doc['name']))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: UtilColors.whiteColor,
                  borderRadius: BorderRadius.circular(20.0)),
              padding: EdgeInsets.all(20.0),
              width: Utils.displaySize.width * 0.8,
              child: Column(
                children: [
                  SizedBox(
                    height: Utils.displaySize.width * 0.4,
                    width: Utils.displaySize.width * 0.4,
                    child: Image.asset(UtilImages.requestPNG),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Request Digital Assets'.toUpperCase(),
                    style: GoogleFonts.openSans(
                        color: UtilColors.blackColor.withOpacity(0.8),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    'Enter the wallet id and required documents'.toUpperCase(),
                    style: GoogleFonts.openSans(
                        color: UtilColors.blackColor.withOpacity(0.8),
                        fontSize: 9.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    color: UtilColors.whiteColor,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  MultiSelectBottomSheetField(
                    items: _documents,
                    selectedItemsTextStyle: GoogleFonts.openSans(
                        color: UtilColors.primaryColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                    autovalidateMode: AutovalidateMode.always,
                    title: Center(
                      child: Text(
                        "Select Documents",
                        style: GoogleFonts.openSans(
                            color: UtilColors.primaryColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    itemsTextStyle: GoogleFonts.openSans(
                        color: UtilColors.blackColor,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600),
                    selectedColor: UtilColors.primaryColor,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                        color: UtilColors.secondaryColor,
                        width: 1,
                      ),
                    ),
                    buttonIcon: Icon(
                      Icons.document_scanner_sharp,
                      color: UtilColors.greyColor.withOpacity(0.8),
                    ),
                    buttonText: Text(
                      "Select Documents",
                      style: GoogleFonts.openSans(
                          color: UtilColors.greyColor.withOpacity(0.8),
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600),
                    ),
                    onConfirm: (result) {
                      print(result);
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 45.0,
                    child: TextFormField(
                      decoration: Utils.getDefaultTextInputDecoration(
                          'Vault ID #',
                          Icon(
                            Icons.code,
                            color: UtilColors.greyColor.withOpacity(0.6),
                          )),
                      cursorColor: UtilColors.primaryColor,
                      keyboardType: TextInputType.emailAddress,
                      style:
                          Utils.getprimaryFieldTextStyle(UtilColors.greyColor),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: TextButton(
                              child: Text(
                                "Close",
                                style: GoogleFonts.openSans(),
                              ),
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          UtilColors.whiteColor),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          UtilColors.redColor)),
                              onPressed: () => Navigator.pop(context),
                            )),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: TextButton(
                              child: Text(
                                "Request",
                                style: GoogleFonts.openSans(),
                              ),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        UtilColors.whiteColor),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        UtilColors.primaryColor),
                              ),
                              onPressed: () async {},
                            )),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
