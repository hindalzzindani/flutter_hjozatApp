import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hjozatapp/pages/widgets/booking_details_card_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/ctm_colors.dart';
import '../../common/ctm_strings.dart';

import '../../models/booking_history_model.dart';
import '../widgets/booking_details_card_widget.dart';
import '../widgets/ctm_header_widget.dart';

class BookingHistoryDetailsPage extends StatefulWidget {
  // FindTicketListModel ticketListModel;

  BookingHistoryModel bookingHistoryModel;
  // Map<String, dynamic> ticketListModel;
  BookingHistoryDetailsPage(this.bookingHistoryModel);

  @override
  State<BookingHistoryDetailsPage> createState() =>
      _BookingHistoryDetailsPageState();
}

class _BookingHistoryDetailsPageState extends State<BookingHistoryDetailsPage> {
  /// init Passenger  value
  String? passengerFirstName;
  String? passengerLastName;
  String? passengerEmail;
  String? passengerMobile;
  String? passengerIdNumber;
  String? passengerIdType;
  String? passengerCountryId;
  String? passengerCountryCity;
  String? passengerAddress;
  String? passengerStatus;
  String? passengerZipCode;
  String? passengerSlug;

  /// init Trip Value

  String? tripid;
  String? fleetId;
  String? scheduleId;
  String? pickLocationId;
  String? dropLocationId;
  String? vehicleId;
  String? distance;
  String? startdate;
  String? journeyHour;
  String? childSeat;
  String? specialSeat;
  String? adultSeat;
  String? adultFair;
  String? childFair;
  String? specialFair;
  String? weekend;
  String? regNo;
  String? companyName;
  String? stoppage;
  String? pickStand;
  String? dropStand;
  String? pickdropstand;
  String? facility;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? type;
  String? layout;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              CtmStrings.bookingDetailsTitle,
              style:  GoogleFonts.cairo(fontSize: 18),
            ),
          ),
          body: _buildBooking(),
          // bottomNavigationBar: _buildFareSummery(),
          bottomSheet: _whatsapp(),
        ));
  }

  // _textformat
  _textformat({ctmKey, ctmValue}) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 20),
          child: Stack(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Expanded(
                  //   flex: 2,
                  //   // child: Text(ctmKey!, style: ctmTxtFormatKeyStyle),
                  // ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '\n\nقم بتأكيد الحجز بالسداد عبر :\n\n\nوارسال صورة الحوالة وصورة الفاتورة\n\n'
                              '\n\n ١/ الكريمي\n\n\n ريال يمني 3017343563\n\nريال سعودي 3017343563'
                              '\n\n ١٢/ حوالة مصرفية باسم :\n\n\n تطبيق حجوزات سفريات ونقل\n\n779164432' +
                          ctmValue!,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Part whats

  _whatsapp() {
    openwhatsapp() async {
      var whatsapp = "+967 779 164 432";
      var whatsappURl_android =
          "whatsapp://send?phone=" + whatsapp + "&text=مرحبا";
      var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("موحبا")}";
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

    return Container(
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
                    // child: Icon(
                    //   // Icons.whatsapp,
                    //   color: Color.fromARGB(255, 248, 250, 248),
                    // ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 1, 121, 61),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(1.5),
              //   child: InkWell(
              //     onTap: () {
              //       openwhatsapp();
              //     },
              //     child: Text(
              //       '\n\nقم بتأكيد الحجز بالسداد عبر :\n\n'
              //       '\n ١/ الكريمي\n\n\n ريال يمني 3017343563\nريال سعودي 3017343563'
              //       '\n\n ١٢/ حوالة مصرفية باسم :\n\n\n تطبيق حجوزات سفريات ونقل\n\n779164432',
              //       style: GoogleFonts.cairo(
              //         color: CtmColors.primaryColor,
              //         fontSize: 14,
              //         fontWeight: FontWeight.bold,
              //         height:
              //             0.9, // 1= 100%, were 0.9 = 90% of actual line height),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(18.5),
                child: InkWell(
                  onTap: () {
                    openwhatsapp();
                  },
                  child: Text(
                    '\n\n  يرجى ارسال إشعار السداد عبر الواتس اب\n\n\n',
                    style: GoogleFonts.cairo(
                      color: CtmColors.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      height:
                          0.9, // 1= 100%, were 0.9 = 90% of actual line height),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBooking() {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: BookingDetailsCardWidget(widget.bookingHistoryModel))
        ],
      ),
    );
  }
}
