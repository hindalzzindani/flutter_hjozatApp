import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/ctm_strings.dart';
import '../../controllers/booking/booking_history_controller.dart';
import '../../models/booking_history_model.dart';
import 'package:get/get.dart';

import '../../common/ctm_style.dart';
import '../../common/theme_helper.dart';
import 'booking_history_deatils_page.dart';

class BookingHistoryPage extends StatefulWidget {
  const BookingHistoryPage({Key? key}) : super(key: key);

  @override
  State<BookingHistoryPage> createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage> {
  BookingHistoryController _bookingHistoryController =
  Get.put(BookingHistoryController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bookingHistoryController.bookingHistoryCTR();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                CtmStrings.bookingHistoryTitle,
                style:  GoogleFonts.cairo(fontSize: 18),
              ),
            ),
            body: Obx(() {
              if (_bookingHistoryController.isDataLoading.value) {
                if (_bookingHistoryController.bookingHistoryList.isEmpty) {
                  return Center(child: Text(CtmStrings.bTicketsRNotAvi));
                } else {
                  return _buildBookingBody();
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            })));
  }

  _buildBookingBody() {
    return Container(
      child: _buildBkHistoryCard(),
    );
  }

  ListView _buildBkHistoryCard() {
    return ListView.builder(
      itemCount: _bookingHistoryController.bookingHistoryList.length,
      shrinkWrap: false,
      padding: EdgeInsets.all(5),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, index) {
        BookingHistoryModel bookingInfo =
        _bookingHistoryController.bookingHistoryList[index];

        return InkWell(
          onTap: () {
            Get.to(BookingHistoryDetailsPage(bookingInfo));
          },
          child: Card(
            elevation: 5,
            child: ListTile(
                leading: Image.network(
                  'https://hjozat.app/backend/public/image/websetting/1661687132_ff3a6b74e60b4fa80ac6.png',
                  alignment: Alignment.centerLeft,
                  color: const Color(0xFF425DA6),
                ),
                title: Text(
                  style:  GoogleFonts.cairo(fontSize: 16),
                  'رقم الحجز :' + bookingInfo.bookingId.toString(),
                ),
                // subtitle: Text(
                //     CtmStrings.bPaymentStatus +
                //         bookingInfo.paymentStatus.toString(),
                //     style:  GoogleFonts.cairo(
                //         fontSize: 12,
                //         color: bookingInfo.paymentStatus.toString() == 'مدفوع'
                //             ? Color.fromARGB(255, 132, 28, 217)
                //             : Colors.deepPurple)
                //
                // ),
                trailing: bookingInfo.paymentStatus.toString() == 'مدفوع'
                    ? Image.network(
                  'https://hjozat.app/backend/public/image/websetting/1661687132_ff3a6b74e60b4fa80ac6.png',
                  alignment: Alignment.centerLeft,
                  color: const Color(0xFF425DA6),
                )
                    : _unpaidPaymentOption()

            ),
          ),
        );
      },
    );
  }

  /// Part whats
  _unpaidPaymentOption() {
    return Container(
      decoration: ThemeHelper().buttonBoxDecoration(context),
      child: ElevatedButton(
        style: ThemeHelper().buttonStyle(context),
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                CtmStrings.bPayment,
                style: ctmPaymentBtnTxtStyleSize14,
              ),
            ],
          ),
        ),
        onPressed: () {
          /// Payment Click
          // Get.toNamed('/StripePayment');
          print('Payment Here ');
        },
      ),
    );
  }
}
