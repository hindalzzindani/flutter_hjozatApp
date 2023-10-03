import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/ctm_back_button_widget.dart';
import '../../common/ctm_colors.dart';
import '../../common/ctm_strings.dart';
import '../../common/shimmer_loading.dart';
import '../../controllers/country_controller/CountryController.dart';
import '../../controllers/trip/find_ticket_trip_controller.dart';
import '../../pages/widgets/booking_now_card_widget.dart';
import '../../pages/widgets/ctm_drawer_widget.dart';
import 'package:get/get.dart';
import '../../controllers/booking/dynamic_seat_plan_controller.dart';
import '../profile_settings/profile_page.dart';

class BookingNowPage extends StatefulWidget {
  String journeyDate;
  String? type;
  BookingNowPage({required this.journeyDate,this.type});

  @override
  State<StatefulWidget> createState() {
    return _BookingNowPageState();
  }
}

class _BookingNowPageState extends State<BookingNowPage> {
  CountryController countryController = Get.put(CountryController());
  FindTicketTripController findTicketTripController =
      Get.put(FindTicketTripController());
  //
  // DynamicSeatPlanController dynamicSeatPlan = DynamicSeatPlanController();

  ShimmerLoading _shimmerLoading = ShimmerLoading();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              CtmStrings.bookingTicketTitle,
              style:
               GoogleFonts.cairo(fontWeight: FontWeight.w400, color: Colors.white),
            ),
            elevation: 0.5,
            iconTheme: IconThemeData(color: CtmColors.appWhiteColor),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor,
                  ])),
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
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
                          color: CtmColors.greyColor300,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          drawer: DrawerWidget(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CtmBackButtonWidget(),
                Obx(() {
                  if (findTicketTripController.isDataLoading.value) {
                    if (findTicketTripController.findTicketsList.length == 0) {
                      return Center(
                          child: Text('لايوجد بيانات!',
                              style:  GoogleFonts.cairo()));
                    } else {
                      return _newbuildBooking();
                    }
                  } else {
                    if (findTicketTripController.isDataEmpty.value) {
                      return Center(
                          child: Text(
                        findTicketTripController.msg.toString(),
                        style:  GoogleFonts.cairo(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ));
                    } else {
                      return Center(
                          child: Text('لايوجدبيانات!',
                              style:  GoogleFonts.cairo()));
                    }
                  }
                }),
              ],
            ),
          ),
        ));
  }

  Widget _newbuildBooking() {
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
                          shrinkWrap: true,
                          itemCount:
                              findTicketTripController.findTicketsList.length,
                          itemBuilder: (context, index) {
                            return BookingNowCardWidget(
                                findTicketTripController.findTicketsList[index],
                                widget.journeyDate.toString(), widget.type,);
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
