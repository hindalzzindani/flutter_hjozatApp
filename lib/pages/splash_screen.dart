import 'dart:async';

import 'package:flutter_hjozatapp/controllers/animate_do.dart';
import 'package:flutter_hjozatapp/local_db_sqflite/db_helper_local.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
//import '../utils/constanst.dart';
import '../../common/ctm_colors.dart';
import '../../common/ctm_strings.dart';
import '../../pages/booking_process/find_tickets_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

final w = Get.width;
final h = Get.height;

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState() {
    new Timer(const Duration(milliseconds: 5000), () {
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => FindTicketPage()),
            (route) => false);
      });
    });

    new Timer(Duration(milliseconds: 10), () {
      setState(() {
        _isVisible =
            true; // Now it is showing fade effect and navigating to Login page
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DBHelper01.getToken('token');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(color: Theme.of(context).primaryColor
          /* gradient: new LinearGradient(
          colors: [Theme.of(context).primaryColor],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),*/
          ),
      child: Scaffold(
        body: SizedBox(
          width: w,
          height: h,
          child: Stack(children: [
            FadeInDown(
              delay: const Duration(milliseconds: 100),
              child: Container(
                width: w,
                height: h / 2,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        stops: [0.3, 0.9],
                        colors: [Colors.blue.shade900, Colors.deepPurple]),
                    // color: const Color(0xFF8C53B5),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(1000),
                        bottomLeft: Radius.circular(1000))),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width / 5.0,
              left: MediaQuery.of(context).size.width / 6.2,
              child: FadeInDown(
                delay: const Duration(milliseconds: 800),
                child: SizedBox(
                  width: w / 1.5,
                  height: h / 10,
                  child: Center(
                    child: Text(
                      "  احجز رحلتك بضغطة زر",
                      style:  GoogleFonts.cairo(
                          color: Color.fromARGB(255, 254, 241, 50),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width / 3.3,
              left: MediaQuery.of(context).size.width / 5.0,
              child: FadeInDown(
                delay: const Duration(milliseconds: 1200),
                child: SizedBox(
                  width: w / 1.5,
                  height: h / 10,
                  child: Center(
                    child: Text(
                      " في أي وقت ومن أي مكان ",
                      style:  GoogleFonts.cairo(
                          color: Color.fromARGB(179, 134, 239, 253),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width / 1.9,
              left: MediaQuery.of(context).size.width / 4.7,
              child: FadeInDown(
                delay: const Duration(milliseconds: 1700),
                child: Container(
                  margin: EdgeInsets.all(15),
                  height: 185.0,
                  width: 185.11,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 5, color: Color.fromARGB(255, 250, 255, 253)),
                    borderRadius: BorderRadius.circular(100),
                    // borderRadius: BorderRadius.circular(50),
                    //set border radius to 50% of square height and width
                    image: DecorationImage(
                      image: AssetImage("assets/images/1.png"),
                      fit: BoxFit.cover, //change image fill type
                    ),
                  ),
                  child: ClipOval(
                    // delay: const Duration(milliseconds: 2000),
                    child: SizedBox(
                      width: w / 1.8,
                      height: h / 3.3,
                      child: Container(
                          child: Center(
                              child: Image.asset(
                        'assets/images/1.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ))),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 70,
              left: 80,
              child: FadeInDown(
                delay: const Duration(milliseconds: 2300),
                child: SizedBox(
                  width: w / 1.6,
                  height: h / 19,
                  child: Center(
                    child: Text(
                      "جميع الحقوق محفوظة لشركة حجوزات",
                      style:  GoogleFonts.cairo(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 155,
              child: FadeInUp(
                delay: const Duration(milliseconds: 2600),
                child: SizedBox(
                  width: w / 5,
                  height: h / 15,
                  child: Center(
                      child: SpinKitFoldingCube(
                    size: 35,
                    itemBuilder: (BuildContext context, int index) {
                      return const DecoratedBox(
                        decoration: BoxDecoration(
                          color: const Color(0xFF8C53B5),
                        ),
                      );
                    },
                  )),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
