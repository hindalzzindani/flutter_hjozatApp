import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/ctm_colors.dart';
import '../../common/ctm_strings.dart';
import '../../controllers/profile/profile_controller.dart';
import '../../local_db_sqflite/db_helper.dart';
import '../../models/profile_info_model.dart';
import '../../pages/widgets/ctm_header_listtitle_widget.dart';
import 'package:get/get.dart';

import '../../local_db_sqflite/db_helper_local.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  ProfileController profileController = ProfileController();

  @override
  Widget build(BuildContext context) {
    _whatsapp() {
      openwhatsapp() async {
        var whatsapp = "+967 779164432";
        var whatsappURl_android =
            "whatsapp://send?phone=" + whatsapp + "&text=مرحبا";
        var whatappURL_ios =
            "https://wa.me/$whatsapp?text=${Uri.parse("موحبا")}";
        if (Platform.isIOS) {
          // for iOS phone only
          if (await canLaunch(whatappURL_ios)) {
            await launch(whatappURL_ios, forceSafariVC: false);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    new Text("المعذرة تطبيق واتس اب غير مثبت في هذا الجهاز!")));
          }
        } else {
          // android , web
          if (await canLaunch(whatsappURl_android)) {
            await launch(whatsappURl_android);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: new Text(
              "المعذرة تطبيق واتس اب غير مثبت في هذا الجهاز!",
            )));
          }
        }
      }

      return Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(2, 0, 0, 0),
            width: double.infinity,
            child: Stack(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: <Widget>[
                    SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: InkWell(
                        onTap: () {
                          openwhatsapp();
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 1, 121, 61),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          // child: Icon(
                          //   Icons.whatsapp,
                          //   color: Color.fromARGB(255, 248, 250, 248),
                          // ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.5),
                      child: InkWell(
                        onTap: () {
                          openwhatsapp();
                        },
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }

    void customLaunch(command) async {
      if (await canLaunch(command)) {
        await launch(command);
      } else {
        print(' could not launch $command');
      }
    }

    return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Drawer(
            backgroundColor: CtmColors.appWhiteColor,
            child: Container(
              height: 520,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [
                    0.0,
                    1.0
                  ],
                      colors: [
                    Theme.of(context).primaryColor.withOpacity(0.0),
                    Theme.of(context).accentColor.withOpacity(0.1),
                  ])),
              child: ListView(
                children: [
                  DrawerHeader(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 1.0],
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor,
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                    width: 5, color: CtmColors.appWhiteColor),
                                color: CtmColors.appWhiteColor,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(31, 255, 255, 255),
                                    blurRadius: 20,
                                    offset: Offset(5, 5),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                'assets/images/2.png',
                                width: 95,
                                height: 95,
                                color: const Color(0xFF425DA6),
                              )
                              //Icon(Icons.person, size: 50, color: Colors.grey.shade300,),
                              ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '   ' + CtmStrings.appName,
                            style: GoogleFonts.cairo(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: CtmColors.appWhiteColor),
                          ),
                        ],
                      )
                      /*  Obx((){
                   if (profileController.isLoadingData.value) {
                     ProfileInfoModel profileInfo = profileController.profile.value;
                     print('mail >>:'+profileInfo.loginEmail.toString());
                     print('Name  >>:'+profileInfo.lastName.toString());
                      return    Column(
                       children: [
                         Container(
                             padding: EdgeInsets.all(10),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(100),
                               border: Border.all(
                                   width: 5, color: CtmColors.appWhiteColor),
                               color: CtmColors.appWhiteColor,
                               boxShadow: [
                                 BoxShadow(
                                   color: Colors.black12,
                                   blurRadius: 20,
                                   offset: const Offset(5, 5),
                                 ),
                               ],
                             ),
                             child: Image.network(
                               'https://bdtask-demo.com/backend/public/image/websetting/1655978324_10b0faacf09c0386ba34.png',
                               width: 50,
                               height: 50,
                               color: Colors.green,
                             )
                           //Icon(Icons.person, size: 50, color: Colors.grey.shade300,),
                         ),
                         SizedBox(
                           height: 10,
                         ),
                         Text(
                           profileInfo.lastName??'user name',
                           style: TextStyle(
                               fontSize: 12,
                               fontWeight: FontWeight.normal,
                               color: CtmColors.appWhiteColor),
                         ),
                         Text(
                   profileInfo.loginEmail??'example@gamil.com',
                           style: TextStyle(
                               fontSize: 12,
                               fontWeight: FontWeight.normal,
                               color: CtmColors.appWhiteColor),
                         ),
                       ],
                     );
                   }
                   else {
                     return    Column(
                       children: [
                         Container(
                             padding: EdgeInsets.all(10),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(100),
                               border: Border.all(
                                   width: 5, color: CtmColors.appWhiteColor),
                               color: CtmColors.appWhiteColor,
                               boxShadow: [
                                 BoxShadow(
                                   color: Colors.black12,
                                   blurRadius: 20,
                                   offset: const Offset(5, 5),
                                 ),
                               ],
                             ),
                             child: Image.network(
                               'https://bdtask-demo.com/backend/public/image/websetting/1655978324_10b0faacf09c0386ba34.png',
                               width: 50,
                               height: 50,
                               color: Colors.green,
                             )
                           //Icon(Icons.person, size: 50, color: Colors.grey.shade300,),
                         ),
                         SizedBox(
                           height: 10,
                         ),
                         Text(
                           'user Name',
                           style: TextStyle(
                               fontSize: 12,
                               fontWeight: FontWeight.normal,
                               color: CtmColors.appWhiteColor),
                         ),
                         Text(
                          'mail@gmail.com',
                           style: TextStyle(
                               fontSize: 12,
                               fontWeight: FontWeight.normal,
                               color: CtmColors.appWhiteColor),
                         ),
                       ],
                     );
                   }
                 })*/

                      ),

                  CtmHeaderListTitleWidget(
                      titleName: "الرئيسية",
                      iconPath: Icons.home,
                      onTapTitle: () => Get.toNamed('/find_ticket')
                      //fontfamily: GoogleFonts.cairo(color: Colors.red,fontSize: 16,fontWeight: FontWeight.w500 ),

                      ),
                  DBHelper01.getToken('token') != null
                      ? Container()
                      : CtmHeaderListTitleWidget(
                          titleName: "دخول",
                          iconPath: Icons.login,
                          onTapTitle: () => Get.toNamed('/login')),

                  DBHelper01.getToken('token') == null
                      ? Container()
                      : CtmHeaderListTitleWidget(
                          titleName: "قائمة حجوزاتي ",
                          iconPath: Icons.history,
                          onTapTitle: () => Get.toNamed('/booking_history')),
                  CtmHeaderListTitleWidget(
                      titleName: "عن التطبيق",
                      iconPath: Icons.multiline_chart_outlined,
                      onTapTitle: () => Get.toNamed('/about_us')),
                  CtmHeaderListTitleWidget(
                      titleName: "سياسة الخصوصية",
                      iconPath: Icons.policy,
                      onTapTitle: () => Get.toNamed('/policy')),
                  CtmHeaderListTitleWidget(
                      titleName: "الشروط والاحكام",
                      iconPath: Icons.note_alt,
                      onTapTitle: () => Get.toNamed('/terms_and_condition')),
                  // CtmHeaderListTitleWidget(
                  //     titleName: "الاسئلة",
                  //     iconPath: Icons.note,
                  //     onTapTitle: () => Get.toNamed('/company_faq')),
                  //CtmHeaderListTitleWidget(
                  //    titleName: "أسئلة شائعة",
                  //   iconPath: Icons.question_mark,
                  //  onTapTitle: () => Get.toNamed('/company_question')),
                  DBHelper01.getToken('token') == null
                      ? Container()
                      : CtmHeaderListTitleWidget(
                          titleName: "تسجيل الخروج",
                          iconPath: Icons.logout,
                          onTapTitle: () {
                            print(' Logout Click');
                            DBHelper01().logout();
                            Get.toNamed('/login');
                          }),

                  Container(
                    height: Get.size.height / 4,
                    width: double.infinity,
                    // color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Text(
                        //   CtmStrings.copyright.toString(),
                        //   style:
                        //     GoogleFonts.cairo(fontStyle: FontStyle.italic),
                        // ),
                        //
                        // Wrap(
                        //   alignment: WrapAlignment.start,
                        //   children: [
                        //     Image.asset("assets/images/awalnet.png",
                        //         color: Color.fromARGB(255, 18, 26, 247),
                        //         width: 50),
                        //     Text(
                        //       "AwalNet Tech",
                        //       style: TextStyle(
                        //         fontFamily: GoogleFonts.oregano().fontFamily,
                        //         fontSize: 25,
                        //         color: Color.fromARGB(255, 18, 69, 212),
                        //       ),
                        //     ),
                        //     Image.asset("assets/images/awalnet.png",
                        //         color: Color.fromARGB(255, 242, 15, 15),
                        //         width: 50),
                        //   ],
                        // ),
                        //

                        // Center(
                        //   child: Padding(
                        //     padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
                        //     // padding: const EdgeInsets.all(8.0),
                        //     child: RichText(
                        //         text: TextSpan(children: [
                        //       TextSpan(
                        //           style: new TextStyle(
                        //               fontFamily: "Ubuntu",
                        //               fontSize: 14,
                        //               color: Colors.red),
                        //           text: "تصميم و تطوير   : AwalNet Technology ",
                        //           recognizer: TapGestureRecognizer()
                        //             ..onTap = () async {
                        //               var url = "http://awalnet.tech";
                        //               if (await canLaunch(url)) {
                        //                 await launch(url);
                        //               } else {
                        //                 throw 'Could not launch $url';
                        //               }
                        //             }),
                        //     ])),
                        //   ),
                        // ),
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              
                              customLaunch('tel:+967 779164432');
                            },

                            //icon data for elevated button
                            label: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "للتواصل عبر الواتس اب ",
                                  style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 26, 73, 155),
                                      fontSize: 10),
                                ),
                              ],
                            ),
                            icon: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/WhatsApp_icon.png',
                                  width: 50,
                                  height: 20,
                                ),
                              ],
                            ),
                            //label text
                          ),
                        ),
                        // Center(
                        //   child: Padding(
                        //     padding: EdgeInsets.only(top: 5.0, bottom: 8.0),
                        //     child: GestureDetector(
                        //       child: Image.asset(
                        //         "assets/images/awalnet.png", // On click should redirect to an URL
                        //         width: 100.0,
                        //         height: 40.0,
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            // padding: const EdgeInsets.all(8.0),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  style: GoogleFonts.cairo(
                                      fontSize: 14, color: Colors.red),
                                  text: "تصميم وتطوير ",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      var url = "http://awalnet.tech";
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    }),
                            ])),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: Column(
                                children: [
                                  Center(
                                    // child: Padding(
                                    //   padding: EdgeInsets.only(top: 12.0, bottom: 0.0),
                                    child: GestureDetector(
                                      child: Image.asset(
                                        'assets/images/awalnet.png',
                                        // On click should redirect to an URL
                                        width: 80.0,
                                        height: 30.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    // ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Padding(
                        //   padding: EdgeInsets.only(top: 5.0, bottom: 0.0),
                        // Positioned.fill(
                        //   //
                        //   child: Image(
                        //     image: AssetImage('assets/images/Pngtree—blue.png'),
                        //     fit: BoxFit.cover,
                        //     width: 300.0,
                        //     height: 65.0,
                        //   ),
                        //   // ),
                        // ),
                        // Text(
                        //   'v-1.0.0',
                        //   style:
                        //     GoogleFonts.cairo(fontStyle: FontStyle.italic),
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     SocialCard(
                        //       icon: "assets/icons/google.svg",
                        //       press: () {},
                        //     ),
                        //     SocialCard(
                        //       icon: "assets/icons/facebook.svg",
                        //       press: () {},
                        //     ),
                        //     SocialCard(
                        //       icon: "assets/icons/phone.svg",
                        //       press: () {},
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
