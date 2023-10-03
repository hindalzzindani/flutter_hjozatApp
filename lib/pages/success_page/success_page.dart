import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/ctm_colors.dart';
import '../../pages/booking_process/booking_history_page.dart';
import '../../pages/booking_process/find_tickets_page.dart';
import 'package:get/get.dart';

import '../../common/theme_helper.dart';

class SuccessFulPage extends StatelessWidget {
  const SuccessFulPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(child: Text('Ticket booking has successful',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),),),
              SizedBox(height: 10),

              Container(
                child: Text(
                  'شكرا لك ',
                  style:  GoogleFonts.cairo(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),

              SizedBox(height: 50),
              Container(
                height: 100,
                width: 100,
                child: CircleAvatar(
                    backgroundColor: const Color(0x445eab),
                    child: Icon(
                      Icons.done_all,
                      size: 50,
                    )),
              ),
              SizedBox(height: 50),
              Container(
                  child: Text('تم حجز التذكرة بنجاح',
                      style:  GoogleFonts.cairo(fontSize: 10))),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  'العودة الى الرئيسية \n  ',
                  style:  GoogleFonts.cairo(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                decoration: ThemeHelper().buttonBoxDecoration(context),
                child: ElevatedButton(
                  style: ThemeHelper().buttonStyle(context),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.home,
                          size: 18,
                          color: CtmColors.appWhiteColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'الرئيسية',
                          style:  GoogleFonts.cairo(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: CtmColors.appWhiteColor),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    Get.offAll((FindTicketPage()));
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: ThemeHelper().buttonBoxDecoration(context),
                child: ElevatedButton(
                  style: ThemeHelper().buttonStyle(context),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.history,
                          size: 18,
                          color: CtmColors.appWhiteColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'قائمة حجوزاتي',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: CtmColors.appWhiteColor),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    Get.to(BookingHistoryPage());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
