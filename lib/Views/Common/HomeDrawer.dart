import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:identifyapp/Controllers/Auth/AuthController.dart';
import 'package:identifyapp/Models/Colors.dart';
import 'package:identifyapp/Models/Utils.dart';
import 'package:identifyapp/Views/Auth/Login.dart';
import 'package:identifyapp/Views/Documents/Documents.dart';
import 'package:identifyapp/Views/Requests/Requests.dart';

class HomeDrawer extends StatefulWidget {
  int selection = 1;

  HomeDrawer({required this.selection});

  @override
  _HomeDrawerState createState() => _HomeDrawerState(selection: this.selection);
}

class _HomeDrawerState extends State<HomeDrawer> {
  int selection;

  _HomeDrawerState({required this.selection});

  AuthController _authController = new AuthController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: double.infinity,
          height: Utils.displaySize.height * 0.15,
          decoration: Utils.getGradientBackground(),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 70.0,
                  width: 70.0,
                  child: ClipOval(
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTt-JmDfLz7ErRiTZ9vIme55A9JGQqdx8qJ_xQ_lB2UIqGAFELpsKQQ8xuTSrlqrly-tSQ&usqp=CAU',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Utils.profileUser.name.toString().toUpperCase(),
                      style: GoogleFonts.openSans(
                          color: UtilColors.whiteColor,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      Utils.profileUser.email.toString(),
                      style: GoogleFonts.openSans(
                          color: UtilColors.whiteColor,
                          fontSize: 10.0,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      Utils.profileUser.mobile.toString(),
                      style: GoogleFonts.openSans(
                          color: UtilColors.whiteColor,
                          fontSize: 10.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        ListTile(
          tileColor: (this.selection == 1)
              ? UtilColors.primaryColor.withOpacity(0.3)
              : UtilColors.whiteColor,
          leading: Icon(
            Icons.home,
            color: UtilColors.blackColor.withOpacity(0.8),
          ),
          title: Text(
            'Home',
            style: GoogleFonts.openSans(
                color: UtilColors.blackColor, fontWeight: FontWeight.w400),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: UtilColors.primaryColor,
            size: 15.0,
          ),
        ),
        ListTile(
          tileColor: (this.selection == 2)
              ? UtilColors.primaryColor.withOpacity(0.3)
              : UtilColors.whiteColor,
          leading: Icon(
            Icons.notifications,
            color: UtilColors.blackColor.withOpacity(0.8),
          ),
          title: Text(
            'Requests',
            style: GoogleFonts.openSans(
                color: UtilColors.blackColor, fontWeight: FontWeight.w400),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: UtilColors.primaryColor,
            size: 15.0,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Requests()));
          },
        ),
        ListTile(
          tileColor: (this.selection == 3)
              ? UtilColors.primaryColor.withOpacity(0.3)
              : UtilColors.whiteColor,
          leading: Icon(
            Icons.document_scanner,
            color: UtilColors.blackColor.withOpacity(0.8),
          ),
          title: Text(
            'Documents',
            style: GoogleFonts.openSans(
                color: UtilColors.blackColor, fontWeight: FontWeight.w400),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: UtilColors.primaryColor,
            size: 15.0,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Documents()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: UtilColors.blackColor.withOpacity(0.8),
          ),
          onTap: () {
            Utils.showLoader(context);
            _authController.logout(context).then((value) {
              Utils.hideLoaderCurrrent(context);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Login()));
            });
          },
          title: Text(
            'Logout',
            style: GoogleFonts.openSans(
                color: UtilColors.blackColor, fontWeight: FontWeight.w400),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: UtilColors.primaryColor,
            size: 15.0,
          ),
        ),
      ],
    );
  }
}
