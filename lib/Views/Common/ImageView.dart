import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:identifyapp/Models/Colors.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageView extends StatefulWidget {
  List<Map<String, dynamic>> galleryItems = [];
  String title = "";

  ImageView({required this.galleryItems, required this.title});

  @override
  _ImageViewState createState() =>
      _ImageViewState(galleryItems: this.galleryItems, title: this.title);
}

class _ImageViewState extends State<ImageView> {
  List<Map<String, dynamic>> galleryItems = [];
  String title = "";

  _ImageViewState({required this.galleryItems, required this.title});

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
                      title,
                      style: GoogleFonts.openSans(
                          color: UtilColors.whiteColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
                child: Container(
                    child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider:
                      MemoryImage(base64Decode(galleryItems[index]['image'])),
                  initialScale: PhotoViewComputedScale.contained * 0.8,
                  heroAttributes:
                      PhotoViewHeroAttributes(tag: galleryItems[index]['id']),
                );
              },
              itemCount: galleryItems.length,
              loadingBuilder: (context, event) => Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(),
                ),
              ),
            )))
          ],
        ),
      ),
    ));
  }
}
