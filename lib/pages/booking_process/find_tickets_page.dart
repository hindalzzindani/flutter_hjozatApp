import 'dart:async';
//import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hjozatapp/models/find_tickets_trip_list_model.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/ctm_alert_widget.dart';
import '../../common/ctm_back_button_widget.dart';
import '../../common/ctm_colors.dart';
import '../../common/ctm_strings.dart';
import 'package:get/get.dart';
import '../../common/ctm_style.dart';
import '../../controllers/country_controller/CountryController.dart';
import '../../local_db_sqflite/db_helper_local.dart';
import '../../pages/booking_process/booking_now_page.dart';
import '../../pages/widgets/ctm_drawer_widget.dart';
import '../../pages/widgets/ctm_header_widget.dart';
import 'package:get/get.dart';
import '../../common/theme_helper.dart';
import '../../controllers/trip/find_ticket_trip_controller.dart';
import '../profile_settings/profile_page.dart';
import '../widgets/booking_now_card_widget.dart';

class FindTicketPage extends StatefulWidget {
  var journeyDate;
  @override
  State<StatefulWidget> createState() {
    return _FindTicketPageState();
  }
}

class _FindTicketPageState extends State<FindTicketPage> {
  CountryController countryController = Get.put(CountryController());

  FindTicketTripController findTicketTripController =
      Get.put(FindTicketTripController());
  String? countryIdForm;
  String? countryIdTo;
  DateTime selectedDateDepart = DateTime.now();
  DateTime? pickCalDate;
  DateTime selectedDateReturn = DateTime.now();
  String returnDateFormatText = 'mm-dd-yyyy';
  bool isCheckDrop = false;
  bool isPreviewDatNotAllow = true;
  DropdownMenuItem dropdownMenuItem = DropdownMenuItem(child: Text(''));

  /// Return ticket Date Picker
  Future<void> _selectDateDepart(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateDepart,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    print(picked);
    if (picked != null && picked != selectedDateDepart) {
      setState(() {
        selectedDateDepart = picked;
      });
    }
  }

  /// Return ticket Date Picker
  Future<void> _selectDateReturn(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateReturn,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateReturn) {
      setState(() {
        selectedDateReturn = picked;
        returnDateFormatText = picked.toString();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      findTicketTripController.findTicketsTripCTRTODAY();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            // iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 0, 0)),
            title: Text(
              CtmStrings.appName.toString(),
              style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),

            iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
            // iconTheme: IconThemeData(color: Colors.white),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor,
                    ]),
              ),
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  left: 16,
                ),
                child: Stack(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        print(' click Token profile  >>>>>' +
                            DBHelper01.getToken('token').toString());
                        if (DBHelper01.getToken('token') != null) {
                          Get.to(ProfilePage());
                        } else {
                          Get.toNamed('/login');
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                              width: 0, color: CtmColors.appWhiteColor),
                          color: CtmColors.appWhiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 50,
                              offset: const Offset(5, 5),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),

          drawer: DrawerWidget(),

          body: _buildBooking(),
          // bottomNavigationBar: SingleChildScrollView(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children:
          //     <Widget>[
          //       ListView.builder(
          //         physics: NeverScrollableScrollPhysics(),
          //         shrinkWrap: false,
          //           itemCount:
          //           findTicketTripController.findTicketsList.length,
          //           itemBuilder: (context, index) {
          //
          //             return
          //               _newbuildBooking(
          //                 findTicketTripController.findTicketsList[index],
          //                 widget.journeyDate.toString());
          //           }),
          //     ],
          //   ),
          // ),

          //
        ));
  }

  /// find tickets body Method
  Widget _buildBooking() {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: 500,
            // width: 5500,
            child: HeaderWidget(200, false, Icons.house_rounded),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(5, 20, 2, 0),
            padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 2.0),
                        alignment: Alignment.topRight,
                        child: Text(
                          "احجز تذكرتك الان ",
                          style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                                  margin: EdgeInsets.fromLTRB(1, 0, 1, 0),
                                  child: Card(
                                    elevation: 2,
                                    child: ListTile(
                                      dense: true,
                                      isThreeLine: true,
                                      //    leading: Icon(Icons.email),
                                      title: Text(
                                        "من مدينة",
                                        style: GoogleFonts.cairo(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),

                                      subtitle: _countryListForm(),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(0, 0, 1, 0),
                                  child: Card(
                                    elevation: 2,
                                    child: ListTile(
                                      dense: true,
                                      isThreeLine: true,
                                      title: Text(
                                        "إلى مدينة",
                                        style: GoogleFonts.cairo(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      subtitle: _countryListTo(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Positioned(
                          //     top: 20,
                          //     left: MediaQuery.of(context).size.width / 2.0,
                          //     child: CircleAvatar(
                          //       backgroundColor: Theme.of(context).primaryColor,
                          //       radius: 17,
                          //       child: Column(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         crossAxisAlignment: CrossAxisAlignment.center,
                          //         children: [
                          //           Icon(
                          //             Icons.arrow_forward,
                          //             size: 14,
                          //           ),
                          //           Icon(
                          //             Icons.arrow_back,
                          //             size: 14,
                          //           ),
                          //         ],
                          //       ),
                          //     ))
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          print(selectedDateReturn);
                          setState(() {
                            if (selectedDateDepart
                                    .compareTo(selectedDateReturn) >
                                0) {
                              isPreviewDatNotAllow = true;
                              print("DT1 is after DT2");
                            }
                          });
                          _selectDateDepart(context);
                        },
                        child: Card(
                          elevation: 2,
                          child: ListTile(
                            trailing: Icon(
                              Icons.calendar_month,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text(
                              "  تاريخ الرحلة ",
                              style: GoogleFonts.cairo(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                                selectedDateDepart.toString().substring(0, 10)),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 5,
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     /// Click Date
                      //     print('Current Date : ' +
                      //         selectedDateReturn.toIso8601String());
                      //     var day = selectedDateReturn.day;
                      //     var month = selectedDateReturn.month;
                      //     var year = selectedDateReturn.year;
                      //     var currentDate = day + month + year;
                      //     print('currentDate' + currentDate.toString());
                      //     _selectDateReturn(context);
                      //   },
                      //   child: Card(
                      //     elevation: 2,
                      //     child: ListTile(
                      //       trailing: Icon(
                      //         Icons.calendar_month,
                      //         color: Theme.of(context).primaryColor,
                      //       ),
                      //       title: Text(
                      //         "الوصول(اختياري)",
                      //         style: GoogleFonts.cairo(
                      //             color: Colors.red,
                      //             fontSize: 16,
                      //             fontWeight: FontWeight.w500),
                      //       ),
                      //       subtitle: Text(returnDateFormatText),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),

                      _buildFindTicketBtn(),
                      SizedBox(
                        height: 10,
                      ),
                      _buildFindTicketBtnTODAY(),
                      Divider(
                        height: 10,
                        thickness: 2.0,
                        indent: 5,
                        color: Theme.of(context).primaryColor,
                      ),
                      Obx(() {
                        return !findTicketTripController
                                .isDataLoadingToday.value
                            ? CircularProgressIndicator()
                            : findTicketTripController.isDataEmptyToday.value
                                ? Container()
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: findTicketTripController
                                        .findTicketsListToday.length,
                                    itemBuilder: (context, index) {
                                      return BookingNowCardWidget(
                                        findTicketTripController
                                            .findTicketsListToday[index],
                                        widget.journeyDate.toString(),
                                        'today',
                                      );
                                    });
                      }),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Location form country id
  _countryListForm() {
    return Obx(() {
      return DropdownButton(
        isExpanded: true,
        isDense: true,
        value: countryIdForm,
        hint: Text(
          "اختر المدينة",
          style: GoogleFonts.cairo(
              color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w500),
        ),
        items: countryController.countryWiseAreaLocationList.map((country) {
          return DropdownMenuItem(
            child: Text(
              country.name.toString(),
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: GoogleFonts.cairo(
                  color: Colors.black54,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
            value: country.id,
          );
        }).toList(),
        onChanged: (String? countryFormId) {
          setState(() {});
          countryIdForm = countryFormId ?? "";
          print("You selected Form Id  : $countryFormId");
        },
      );
    });
  }

  /// Location form country id
  _countryListTo() {
    return Obx(() {
      return DropdownButton(
        isDense: true,
        isExpanded: true,
        value: countryIdTo,
        hint: Text(
          "اختر المدينة",
          style: GoogleFonts.cairo(
              color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w500),
        ),
        items: countryController.countryWiseAreaLocationList.map((country) {
          return DropdownMenuItem(
            child: Text(
              country.name.toString(),
              style: GoogleFonts.cairo(
                  color: Colors.black45,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
            value: country.id,
          );
        }).toList(),
        onChanged: (String? countryToId) {
          setState(() {});
          countryIdTo = countryToId ?? "";
          print("You selected To: $countryToId");
        },
      );
    });
  }

  /// find tickets button action method
  _buildFindTicketBtn() {
    return Container(
      decoration: ThemeHelper().buttonBoxDecoration(context),
      child: ElevatedButton(
        style: ThemeHelper().buttonStyle(context),
        child: Padding(
          padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.find_in_page_sharp,
                size: 30,
                color: CtmColors.appWhiteColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'احجز  تذكرتك',
                style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),

                //style:ctmPaymentBtnTxtStyle,
                // GoogleFonts.cairo(color: Colors.red,fontSize: 16,fontWeight: FontWeight.w500 ),
              ),
            ],
          ),
        ),
        onPressed: () {
          Map<String, dynamic> findTicketsMapBody = {
            "pick_location_id": countryIdForm,
            "drop_location_id": countryIdTo,
            "journeydate": selectedDateDepart.toString(),
          };

          print('fTicketBodyMap: ' + findTicketsMapBody.toString());

          if (countryIdForm != null && countryIdTo != null) {
            if (isPreviewDatNotAllow) {
              ///done
              findTicketTripController.findTicketsTripCTR(findTicketsMapBody);
              Get.to(BookingNowPage(
                  journeyDate: selectedDateDepart.toString().substring(4, 10)));
            } else {
              CtmAlertDialog.fieldAlertDialog(
                  CtmStrings.fieldAlert, CtmStrings.dateNotAllow);
            }
          } else {
            print("here");
            CtmAlertDialog.fieldAlertDialogError(
                CtmStrings.fieldAlert, CtmStrings.plzSelectLocation);
          }
        },
      ),
    );
  }

  /// find tickets button action method
  _buildFindTicketBtnTODAY() {
    return Container(
      decoration: ThemeHelper().buttonBoxDecoration(context),
      child: ElevatedButton(
        style: ThemeHelper().buttonStyle(context),
        child: Padding(
          padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.find_in_page_sharp,
                size: 30,
                color: CtmColors.appWhiteColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'كـــل الرحلات',
                style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),

                //style:ctmPaymentBtnTxtStyle,
                // GoogleFonts.cairo(color: Colors.red,fontSize: 16,fontWeight: FontWeight.w500 ),
              ),
            ],
          ),
        ),
        onPressed: () {
          Map<String, dynamic> findTicketsMapBody = {
            "journeydate": selectedDateDepart.toString(),
          };

          print('fTicketBodyMap: ' + findTicketsMapBody.toString());

          if (isPreviewDatNotAllow) {
            ///done
            findTicketTripController
                .findTicketsTripOnlyDateCTR(findTicketsMapBody);
            Get.to(BookingNowPage(
                journeyDate: selectedDateDepart.toString().substring(4, 10)));
          } else {
            CtmAlertDialog.fieldAlertDialog(
                CtmStrings.fieldAlert, CtmStrings.dateNotAllow);
          }
        },
      ),
    );
  }

  _newbuildBooking(
      FindTicketListModel findTicketsList, Comparable<String> string) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(2, 5, 2, 5),
            padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(1, 5, 1, 2),
                  padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                  child: Column(
                    children: <Widget>[
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: false,
                          itemCount:
                              findTicketTripController.findTicketsList.length,
                          itemBuilder: (context, index) {
                            return _newbuildBooking(
                                findTicketTripController.findTicketsList[index],
                                widget.journeyDate.toString());
                          }),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
