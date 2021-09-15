import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:identifyapp/Controllers/Documents/DocumentValidation.dart';
import 'package:identifyapp/Controllers/Documents/DocumentsController.dart';
import 'package:identifyapp/Models/Colors.dart';
import 'package:identifyapp/Models/Utils.dart';
import 'package:image_picker/image_picker.dart';

class NewDocument extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewDocumentState();
}

class NewDocumentState extends State<NewDocument> {
  static List<Map<String, dynamic>> _docs = Utils.docs;

  DocumentsController _documentsController = DocumentsController();

  final ImagePicker _picker = ImagePicker();
  late Uint8List _image1 = Uint8List(0);
  late Uint8List _image2 = Uint8List(0);

  int _selectedValue = 0;
  late bool _hasField = false;
  String _fieldName = "";
  bool _needValidate = false;
  String _validatePattern = "";

  TextEditingController _nickname = TextEditingController();
  TextEditingController _extradata = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Form(
            key: _formKey,
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
                          controller: _nickname,
                          decoration: Utils.getDefaultTextInputDecoration(
                              'Document Nick Name',
                              Icon(
                                Icons.code,
                                color: UtilColors.greyColor.withOpacity(0.6),
                              )),
                          cursorColor: UtilColors.primaryColor,
                          keyboardType: TextInputType.emailAddress,
                          style: Utils.getprimaryFieldTextStyle(
                              UtilColors.greyColor),
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

                              _needValidate = _docs[val]['validate'];

                              if (_hasField == false) {
                                _extradata.text = "";
                              } else {
                                _fieldName = _docs[val]['fieldName'];
                              }

                              if (_needValidate == true) {
                                _validatePattern = _docs[val]['pattern'];
                              }
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
                              controller: _extradata,
                              decoration: Utils.getDefaultTextInputDecoration(
                                  _fieldName,
                                  Icon(
                                    Icons.code,
                                    color:
                                        UtilColors.greyColor.withOpacity(0.6),
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
                                (_image1.length > 0 && _image1.isNotEmpty)
                                    ? UtilColors.greenColor
                                    : UtilColors.primaryColor),
                          ),
                          onPressed: () async {
                            await _picker
                                .pickImage(
                                    source: ImageSource.camera, imageQuality: 5)
                                .then((image1) async {
                              if (image1 != null) {
                                _image1 = await image1.readAsBytes();
                                setState(() {});
                              }
                            });
                          },
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
                                (_image2.length > 0 && _image2.isNotEmpty)
                                    ? UtilColors.greenColor
                                    : UtilColors.primaryColor),
                          ),
                          onPressed: () async {
                            await _picker
                                .pickImage(
                                    source: ImageSource.camera, imageQuality: 5)
                                .then((image2) async {
                              _image2 = await image2!.readAsBytes();
                              setState(() {});
                            });
                          },
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
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      if (_nickname.text.isNotEmpty) {
                                        if (_image1.length > 0) {
                                          Utils.showLoader(context);
                                          await _documentsController
                                              .saveNewDocument(
                                                  _nickname.text,
                                                  _extradata.text,
                                                  base64Encode(_image1),
                                                  (_image2.length > 0)
                                                      ? base64Encode(_image2)
                                                      : "",
                                                  _selectedValue)
                                              .then((value) {
                                            Utils.hideLoaderCurrrent(context);
                                            if (value == true) {
                                              Navigator.pop(context);
                                            }
                                          });
                                        } else {
                                          Utils.showToast(
                                              'Please Fill Image 1');
                                        }
                                      } else {
                                        Utils.showToast(
                                            'Please Fill Document Nickname');
                                      }
                                    } else {
                                      Utils.showToast('Please fill');
                                    }
                                  },
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
