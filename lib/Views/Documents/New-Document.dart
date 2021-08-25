import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:identifyapp/Controllers/Documents/DocumentValidation.dart';
import 'package:identifyapp/Models/Colors.dart';
import 'package:identifyapp/Models/Images.dart';
import 'package:identifyapp/Models/Utils.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class NewDocument extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewDocumentState();
}

class NewDocumentState extends State<NewDocument> {
  static List<Map<String, dynamic>> _docs = [
    {"id": 0, "name": "None", "hasNumber": true, "fieldName": ""},
    {
      "id": 1,
      "name": "National Identity Card",
      "hasNumber": true,
      "fieldName": "NIC Number",
      "validate": true,
      "pattern": DocumentValidation.patternNIC
    },
    {
      "id": 2,
      "name": "Birth Certificate",
      "hasNumber": false,
      "fieldName": "",
      "validate": false
    },
    {
      "id": 3,
      "name": "Passport",
      "hasNumber": true,
      "fieldName": "Passport Number",
      "validate": true,
      "pattern": DocumentValidation.patternPassport
    },
    {
      "id": 4,
      "name": "Covid Vaccinated Report",
      "hasNumber": false,
      "fieldName": "",
      "validate": false
    },
  ];

  int _selectedValue = 0;
  late bool _hasField = false;
  String _fieldName = "";
  bool _needValidate = false;
  String _validatePattern = "";

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
                  Text(
                    'Create New Document'.toUpperCase(),
                    style: GoogleFonts.openSans(
                        color: UtilColors.blackColor.withOpacity(0.8),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    'Please fill below to create digital documents'
                        .toUpperCase(),
                    style: GoogleFonts.openSans(
                        color: UtilColors.blackColor.withOpacity(0.8),
                        fontSize: 9.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: UtilColors.whiteColor,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 45.0,
                    child: TextFormField(
                      decoration: Utils.getDefaultTextInputDecoration(
                          'Document Nick Name',
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
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 45.0,
                    child: DropdownButtonFormField<int>(
                      isExpanded: true,
                      value: _selectedValue,
                      style: GoogleFonts.openSans(
                          color: UtilColors.blackColor.withOpacity(0.8),
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600),
                      onChanged: (val) {
                        setState(() {
                          _selectedValue = val!;
                          _hasField = _docs[val]['hasNumber'];
                          _fieldName = _docs[val]['fieldName'];
                          _needValidate = _docs[val]['validate'];
                          _validatePattern = _docs[val]['pattern'];
                        });
                      },
                      items: _docs
                          .map((_doc) => DropdownMenuItem(
                                child: Text(_doc['name']),
                                value: _doc['id'] as int,
                              ))
                          .toList(),
                      decoration: Utils.getDefaultDropdownInputDecoration(
                          "Document Type"),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Visibility(
                      visible: _hasField,
                      child: SizedBox(
                        height: 45.0,
                        child: TextFormField(
                          decoration: Utils.getDefaultTextInputDecoration(
                              _fieldName,
                              Icon(
                                Icons.code,
                                color: UtilColors.greyColor.withOpacity(0.6),
                              )),
                          cursorColor: UtilColors.primaryColor,
                          keyboardType: TextInputType.emailAddress,
                          style: Utils.getprimaryFieldTextStyle(
                              UtilColors.greyColor),
                          validator: (value) {
                            if (_needValidate) {
                              if (!DocumentValidation()
                                  .validation(value!, _validatePattern)) {
                                return 'Invalid $_fieldName';
                              }
                              return null;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            if (_needValidate) {
                              if (!DocumentValidation()
                                  .validation(value, _validatePattern)) {
                                print('Invalid $_fieldName');
                              } else {
                                print('Valid $_fieldName');
                              }
                            }
                          },
                        ),
                      )),
                  (_hasField)
                      ? SizedBox(
                          height: 10.0,
                        )
                      : Container(),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      child: Text(
                        "Upload Image 1",
                        style: GoogleFonts.openSans(),
                      ),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            UtilColors.whiteColor),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            UtilColors.primaryColor),
                      ),
                      onPressed: () async {},
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      child: Text(
                        "Upload Image 2",
                        style: GoogleFonts.openSans(),
                      ),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            UtilColors.whiteColor),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            UtilColors.primaryColor),
                      ),
                      onPressed: () async {},
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
                                "Create",
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
