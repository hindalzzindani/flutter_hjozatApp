import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import 'package:flutter_hjozatapp/pages/widgets/booking_details_card_widget.dart';
import 'package:flutter_hjozatapp/pages/widgets/booking_details_card_widget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screenshot/screenshot.dart';
import '../../common/ctm_colors.dart';
import '../../common/ctm_style.dart';
import '../../common/theme_helper.dart';
import '../../models/booking_history_model.dart';
// import '../..//models/find_ticket_trip_controller.dart';
// import 'package:share_plus/share_plus.dart';

import '../../models/find_tickets_trip_list_model.dart';
import 'booking_details_card_widget.dart';
import 'booking_details_card_widget.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
class BookingDetailsCardWidget extends StatelessWidget {
  BookingHistoryModel bookingHistoryInfo;
  final _screenshotController = ScreenshotController();

  // BookingHistoryModel BookingInfoBodyMap = BookingHistoryModel();

  BookingDetailsCardWidget(this.bookingHistoryInfo);

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
  String policyString =
      " إن أي طلب من حسابك يتم التعامل معه بجدية لذا يجب عليك التأكد من أن حسابك لا يستخدمه أحدا غيرك، وبذلك لا تتحمل منصة hjozat  أي مسؤولية تنجم عن استخدام حسابك الخاص عند مواجهتك أي صعوبة في التعامل مع إدخال العنوانين يمكنك التواصل مع الدعم التقني الخاص بنا وسنساعدك بالطريقة التي تستطيع ان تضيف بها العناوين التي تريدهايحتفظ تطبيق حجوزات بتقييم تجربة المستخدمين ومعلومات الحجز لخاصة بهم , والتي تساعدنا نحن كفريق عمل في تقديم أفضل خدمة لعملائنا ";

  @override
  Widget build(BuildContext context) {

    return Container(
      //color: Colors.green,
      margin: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
      // height: MediaQuery.of(context).size.height / 1,
      width: double.infinity,
      child: Card(
        elevation: 5,
        child: _buildBookingHistoryDetailsCardUI(context),
      ),
    );

  }

  ///Booking Details
  _buildBookingHistoryDetailsCardUI(BuildContext context) {

   // final url = UrlImageri.parse(UrlImage);
   void _takeScreenshot() async {

      final imageFile = await _screenshotController.capture();
      // Share.shareFiles([imageFile.path], text: "Shared from #SexyFlutterApp");
    }


    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Image.asset(
        'assets/images/2.png',
        width: 190,
        height: 90,alignment: Alignment.center,
        color: const Color(0xFF425DA6)),
          Text('فـاتـورةالحـجـز ',textAlign: TextAlign.center,
              style:  GoogleFonts.cairo(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          Screenshot(
            controller: _screenshotController,
            child: Card(
              color: Theme.of(context).cardColor,
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: CtmColors.appWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                child: Column(
                  // _buildPaymentTitleHeader('بيانات المسافر');
                  children: [
                    customTextFormatWithValueRowLine(
                        'رقم الحجز ', bookingHistoryInfo.bookingId.toString()),

                    // _textformat(ctmKey: 'اسم الشركة', ctmValue: '$companyName'),

                    customTextFormatWithValueRowLine(
                        'سعر التذكرة', bookingHistoryInfo.paidamount.toString()),
                    customTextFormatWithValueRowLine(
                        ' الشركة ', bookingHistoryInfo.regno.toString()),

                    customTextFormatWithValueRowLine(
                        ' اسم المسافر', bookingHistoryInfo.first_name.toString()),
                    customTextFormatWithValueRowLine(
                        ' اللقب ', bookingHistoryInfo.last_name.toString()),
                    customTextFormatWithValueRowLine(
                        ' رقم الهوية', bookingHistoryInfo.id_number.toString()),

                    // customTextFormatWithValueRowLine(
                    //     ' من مدينة ', bookingHistoryInfo.picklocation.toString()),
                    // customTextFormatWithValueRowLine('  الي مدينة ',
                    //     bookingHistoryInfo.droplocation.toString()),

                    // customTextFormatWithValueRowLine(' ',
                    //     bookingHistoryInfo.paymentStatus.toString()),
                  ],
                ),
              ),
            ),
          ),

          Card(
            color: Theme.of(context).cardColor,
            elevation: 8,
            child: Container(
              decoration: BoxDecoration(
                color: CtmColors.appWhiteColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      flex: 1,
                      child: customTextFormatWithValueWithIconRowLine(
                          'من مدينة ',
                          bookingHistoryInfo.picklocation.toString(),
                          Icon(
                            Icons.add_location,
                            size: 18,
                          ))),
                  Expanded(
                      flex: 1,
                      child: customTextFormatWithValueWithIconRowLine(
                          'إلى مدينة  ',
                          bookingHistoryInfo.droplocation.toString(),
                          Icon(
                            Icons.add_location,
                            size: 16,
                          ))),
                ],
              ),
            ),
          ),
          // Text(
          //     'بيانات المسافر',
          //     style:  GoogleFonts.cairo(color: Colors.black, fontWeight: FontWeight.bold)),
          Divider(
            color: Colors.grey,
            thickness: 0.2,
          ),
          // customTextFormatWithValueRowLine(
          //     'الاجرة', bookingHistoryInfo.offerer.toString()),
          // // customTextFormatWithValueRowLine(
          // //     'رقم المقعد', bookingHistoryInfo.seatnumber.toString()),
          // bookingHistoryInfo.special == ''
          //     ? Container()
          //     : customTextFormatWithValueRowLine(
          //         'مقعدخاص', bookingHistoryInfo.special.toString()),
          // bookingHistoryInfo.adult == ''
          //     ? Container()
          //     : customTextFormatWithValueRowLine(
          //         'بالغين', bookingHistoryInfo.adult.toString()),
          // bookingHistoryInfo.chield == ''
          //     ? Container()
          //     : customTextFormatWithValueRowLine(
          //         'أطفال', bookingHistoryInfo.chield.toString()),
          // customTextFormatWithValueRowLine(
          //     'إجمال المقاعد', bookingHistoryInfo.totalseat.toString()),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Expanded(
              //     flex: 1,
              //     child: customTextFormatWithValueRowLine(
              //         'الخصم', bookingHistoryInfo.discount.toString())),
              // Expanded(
              //     flex: 1,
              //     child: customTextFormatWithValueRowLine(' النوع', 'نقدا')),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Expanded(
              //     flex: 1,
              //     child: customTextFormatWithValueRowLine(
              //         'المراجعة', bookingHistoryInfo.reviewStatus.toString())),
              // Expanded(
              //     flex: 1,
              //     child: customTextFormatWithValueRowLine('حالة الحجز',
              //         bookingHistoryInfo.cancelStatus.toString())),
            ],
          ),
          Divider(
            // color: Colors.grey,
            thickness: 0.2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 2,
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                    child: customTextFormatWithValueRowLine(
                        'تاريخ الرحله',
                        bookingHistoryInfo.journeydata
                            .toString()
                            .substring(0, 10))),
              ),
            ],
          ),
          Divider(
            // color: const Color(0xFF8C53B5),
            thickness: 0.2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Expanded(
              //   flex: 2,
              //   child: Container(
              //     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              //     decoration: ThemeHelper().buttonBoxDecoration(context),
              //     child: ElevatedButton(
              //       style: ThemeHelper().buttonStyle(context),
              //       child: Padding(
              //         padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
              //         child: Row(
              //           mainAxisSize: MainAxisSize.min,
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           children: [
              //             Icon(
              //               Icons.share,
              //               size: 18,
              //               color: CtmColors.appWhiteColor,
              //             ),
              //             SizedBox(
              //               width: 15,
              //             ),
              //             Text('مشاركــة الفاتورة ',
              //                 style:  GoogleFonts.cairo(
              //                     color: Colors.white,
              //                     fontWeight: FontWeight.bold)),
              //           ],
              //         ),
              //       ),
              //       onPressed: _takeScreenshot,
              //     ),
              //   ),
              // ),
              //
              // Expanded(
              //   flex: 3,
              //   child:
              //   Container(
              //     margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              //     decoration: ThemeHelper().buttonBoxDecoration(context),
              //     child: ElevatedButton(
              //       style: ThemeHelper().buttonStyle(context),
              //       child: Padding(
              //         padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
              //         child: Row(
              //           mainAxisSize: MainAxisSize.min,
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           children: [
              //             Icon(
              //               Icons.download,
              //               size: 18,
              //               color: CtmColors.appWhiteColor,
              //             ),
              //             SizedBox(
              //               width: 5,
              //             ),
              //             Text(
              //               'Download PDF File ',
              //               style: ctmPaymentBtnTxtStyleSize14,
              //             ),
              //           ],
              //         ),
              //       ),
              //       onPressed: () {
              //
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  // _textformat
  _textformat({ctmKey, ctmValue}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: Text(ctmKey!, style: ctmTxtFormatKeyStyle),
          ),
          Expanded(
            flex: 1,
            child: Text(
              " : " + ctmValue!,
              maxLines: 2,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }

  /// Part Threeبيانات الرحله
  _buildFareSummery() {
    return Card(
      elevation: 2,
      child: Container(
        width: double.infinity,
        child: Padding(
          padding:
          const EdgeInsets.only(left: 0, top: 15, right: 15, bottom: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // _textformat(
              //     ctmKey: 'سعر التذكرة ',
              //     ctmValue: 'ريال ${Pass.toString()}'),
              // _textformat(ctmKey: 'الضريبة', ctmValue: 'ريال $tax'),
              _textformat(ctmKey: 'اسم الشركة', ctmValue: '$regNo'),
              // _textformat(ctmKey: 'نوع الناقلة', ctmValue: '$reg_no'),
              // _textformat(ctmKey: 'المعدل الفرعي', ctmValue: 'ريال $subAmount'),
              // _textformat(ctmKey: 'الخصم', ctmValue: 'ريال $discount'),
              Divider(
                height: 10,
                thickness: 1.5,
              ),
              // _textformat(ctmKey: 'اجمالي السعر', ctmValue: 'ريال $totalPrice'),
              // CtmTextWithKeyValueRowLineWidget(ctmKey: "Total Amount", ctmValue: "৳$totalPrice"),
            ],
          ),
        ),
      ),
    );
  }
  ///Format Row Line Text Format
  Widget customTextFormatWithValueRowLine(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Text(key + ' : ',
              style:  GoogleFonts.cairo(
                  color: Colors.black, fontWeight: FontWeight.bold)),
          Text(
            value,
            maxLines: 2,
            style:  GoogleFonts.cairo(
                color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold),
            overflow: TextOverflow.clip,
          ),
        ],
      ),
    );

  }

  ///Format Row Line Text With Icon Format
  Widget customTextFormatWithValueWithIconRowLine(
      String key, String value, Icon icon) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        children: [
          icon,
          Text(key + ' : ',
              style:  GoogleFonts.cairo(
                  color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold)),
          Text(
            value,
            style:  GoogleFonts.cairo(
                color: Colors.black38, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
        ],
      ),
    );

  }

}
