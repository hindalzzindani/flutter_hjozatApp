import 'package:flutter/material.dart';
import 'package:flutter_hjozatapp/pages/payment_method/payment_system.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/ctm_colors.dart';
import '../../common/ctm_strings.dart';
import '../../pages/payment_method/payment_system.dart';
import '../../common/ctm_style.dart';
import '../../models/find_tickets_trip_list_model.dart';
import '../../pages/review_section/reviews.dart';
import 'package:get/get.dart';
import '../../common/ctm_alert_widget.dart';
import '../../common/ctm_back_button_widget.dart';
import '../../common/theme_helper.dart';
import '../../controllers/booking/dynamic_seat_plan_controller.dart';
import '../../local_db_sqflite/db_helper.dart';
import '../../local_db_sqflite/db_helper_local.dart';
import '../booking_process/pickup_and_drop_page.dart';
// import '../payment_method/payment_system.dart';
// import '../payment_method/payment_system.dart';
import '../photos_section/photos_page.dart';
import 'ctm_review_card_widget.dart';

class BookingNowCardWidget extends StatelessWidget {
  final String? type;
  String policyString =
      " • ان  تطبيق حجوزات حلقة وصل بين المستخدم ومزود الخدمة (شركات النقل وسائقي المركبات ) لذا فان الاسعار تتغير في التطبيق بناء على الاسعار المحددة من قبل شركات النقل والسائقين ولكن لا تختلف الاسعار عن اسعار الشركة"
      "• السعر الاجمالي يتضمن جميع رسوم الضرائب الاساسية لحجز الرحلة ولا يتضمن الرسوم للعفش الاضافي –الوزن الزائد او راكب غير مذكور في التذكرة"
      " • يتضمن علي المستخدم دفع اجمالي المبلغ المستحق كي يتم تاكيد الحجز بعد الحجز مباشرة تفاديا لتغير الاسعار من وقت لاخر بحسب سياسات الشركات والمواسم وفوارق صرف العملات  "
      "• لن يتم استرجاع مبلغ الحجز في حال التغيب عن الرحلة وعدم الاشعار قبل 48 ساعة من موعد الحجز "
      "• لمعرفة امكانية الغاء الحجز خلال 48 ساعة المتبقي لموعد الرحلة يرجى التواصل عن طريق ادارة حجوزات "
      " • يمكنك الحجز من أي مكان في العالم ولكن انطلاق الرحلة سوف يكون من المدينة المخصصة التي تم اختيارها اثناء الحجز "
      "• تاكد من استخدام جواز السفر ساري المفعول لمدة 6 اشهر علي الاقل قبل تاشيرة الدخول للملكة , تاشيرة  الدخول والمغادرة وجميع الاوراق الرسمية ولا يتحمل تطبيق حجوزات او شركة النقل أي مسؤولية قانونيه في حال لم تكن ارواقك سليمة "
      " • يحب علي المستخدم او المسافر اتمام اجراءات السفر والتاكد من الحصول على صورة التذكرة بعد الحجز او قبل مغادرة الرحلة ب 3 ساعات على الاقل واثبات هوية حامل التذكرة الخاصة بتطبيق حجوزات للشركة الناقلة  "
      " • يحق للراكب التواصل مع شركة الباصات بشكل مباشر لادارة عملة الحجز الخاص به دون الرجوع للتطبيق ولكن على مسؤوليته الشخصية ولا يتحمل تطبيق حجوزات أي تعامل الاطار الرسمي لديه وليس بامكان تطبيق حجوزات استرداد مبلغ الحجز في هذه الحال او تحمل أي مسؤولية قانونيه لاي قضايا اخرى مترتبة على ذلك "
      " • ان تطبيق حجوزات غير مسؤول عن أي تغير في الجدول الزمني او تاخير الرحلة بعد تاكيد الحجز واصدار تذكرة السفر وسنقوم باعلامك  حال ما يصلنا أي اشعار مسبق من الشركة بذلك ولاننا لانضمن لك دقة مواعيد الرحلات ننصحك بالتأكد من الاوقات المقرره لرحلتك قبل 24 ساعة من وقت المغادرة"
      " • سلامة الركاب مسؤولية شركة الباصات  والتامين عليهم ولا يتحمل تطبيق حجوزات أي مسؤوليه قانوينه عن ذلك  "
      " • جميع معلومات الراكب التي تقدم تعتبر مسؤوليه خاصة بالراكب وليس للتطبيق أي دخل لتلك المعلومات ويعتبر التطبيق وسيط حجز فقط  فقط لتسهيل الحجز للراكب فقط  "
      " • لا يقوم الركاب بدفع أي رسوم للتطبيق او رسوم اضافية غير الموضحه لديه في سعر التذكرة والتي يعتبر بنفس سعر الحجز التي تقدم من الشركة للتطبيق  سياسات الغاء الحجز  "
      " • سوف يتم الغاء الحجز في حال طلب الغاء الحجز اثناء المده المسموحه او تعديل علي الرحلة وسوف يقوم فريق تطبيق حجوزات بالغاء الحجز السابق واصدار حجز جديد وفي حال قام الراكب بتاكيد الحجز او ارسال رسوم الحجز يرجى التواصل مع ادارة حجوزات لادارة ذلك  "
      " • الغاء الحجز عبر التطبيق يخضع لسياسات شركة الباصات وتطبيق حجوزات"
      "• لطلبات الحجز عليك التواصل مع ادارة حجوزات للتاكد من الغاء الحجز سياسات الاسترجاع "
      "• سوف يتم استرجاع او دفع رسوم الحجز في تغير المواعيد وسعر التذكرة الجديده اقل او اكثر من سعر التذكرة السابق "
      "• بعض الحجوزات غير قابلة للاسترداد وذلك تبعا للسياسات الخاصة بشركات النقل "
      "• يتم استرداد مبالغ الحجز عن طريق شركات الباصات بشكل مباشر الى الراكب وليس عن طريق التطبيق بعد استقطاع مبلغ الغاء الحجز وغيرها من الرسوم التي تخضع للاستقطاع لدى شركات الباصات "
      "سياسات التعديل "
      "• بامكانك اجراء أي تعديلات علي حجز رحلتك بحسب المواعيد والجداول المتوفرة في تطبيق حجوزات وبالنظر الى ان تطبيق حجوزات يقوم بعملة وسيط الحجز ويخضع لجميع قواعد الحجز لشركات الباصات ومواعيدها بشكل اساسي"
      "• يتعين عليك دفع رسوم الفارق بين سعر التذكرة الجديده او القديمة ليتم ععملية التعديل على الحجز اثناء الفترة المسموح بها";



  FindTicketListModel ticketListModel;
  String journeydate = '';
  String tripId = '';
  BookingNowCardWidget(this.ticketListModel, this.journeydate, this.type);

  bool isShow = false;

  final listAdd = <Widget>[];
  // DynamicSeatPlanController dynamicSeatPlanController =
  //     Get.put(DynamicSeatPlanController());

  @override
  Widget build(BuildContext context) {
    print('money Symbel : ' + CtmStrings.currencySymbol.toString());

    tripId = ticketListModel.tripid.toString();
    journeydate = journeydate.toString();
    print(' tripId +Date :' + tripId + ' ' + journeydate);

    /// this controller need to dynamic seat
    // dynamicSeatPlanController.dynamicSeatPan(tripId, journeydate);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
      width: double.infinity,
      child: Card(
        // margin: EdgeInsets.symmetric(vertical: 22, horizontal: 11),
        // padding: EdgeInsets.symmetric(vertical: 22, horizontal: 18),
        elevation: 5,
        child: _buildLeftCardUI(context),
      ),
    );
  }

  ///left site
  _buildLeftCardUI(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      // margin: EdgeInsets.symmetric(vertical: 22, horizontal: 11),
      padding: EdgeInsets.symmetric(vertical: 22, horizontal: 18),
      // color: Colors.yellow,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // ctmTextFormatValueRow(
          //     'شعارالشركة', '', ticketListModel.companyName ?? 'no compnay'),
          type!='today'?Container():
          ctmTextFormatValueRow(
              'تاريخ الرحله', '', ticketListModel.startdate ?? ''),
          type=='today'?Container():
          ctmTextFormatValueRow(
              'تاريخ الرحله', '', ticketListModel.startdate ?? ''),
          type!='today'?Container():ctmTextFormatValueRow(
              'من مدينة', '', ticketListModel.pickLocation ?? ''),
          type!='today'?Container():ctmTextFormatValueRow(
              'إلى مدينة', '', ticketListModel.dropLocation ?? ''),
          type=='today'?Container():ctmTextFormatValueRow(
              'من مدينة', '', ticketListModel.pickLocation ?? ''),
          type=='today'?Container():ctmTextFormatValueRow(
              'إلى مدينة', '', ticketListModel.dropLocation ?? ''),
          ctmTextFormatValueRow(
              ' الشركة', '', ticketListModel.regNo ?? 'no compnay'),
          ctmTextFormatValueRow('وقت الرحلة', '',
              ticketListModel.startTime ?? '00:00' + '[' + 'Dhaka' + ']'),
          ctmTextFormatValueRow('وسيلة النقل ', '',
              ticketListModel.fleet_type ?? '00:00' + '[' + 'Dhaka' + ']'),


          // dhaka find tickets arg pass
          ticketListModel.adultFair == ""
              ? Container()
              : ctmTextFormatValueRow('سعــر التذكرة',
                  CtmStrings.currencySymbol, ticketListModel.adultFair ?? '0'),
          // ctmTextFormatValueRow('الوصول', '',
          //     ticketListModel.endTime ?? '00:00' + '[' + 'Dhaka' + ']'),

          // InkWell(
          //   onTap: () {
          //     print('Photos Click');
          //     Get.to(PhotoPage());
          //   },
          //   child: Container(
          //       decoration: BoxDecoration(
          //         color: Colors.grey.shade200,
          //         borderRadius: BorderRadius.circular(5),
          //       ),
          //       margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          //       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          //       child: Row(
          //         mainAxisSize: MainAxisSize.max,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Icon(
          //             Icons.image,
          //             size: 18,
          //             color: Theme.of(context).primaryColor,
          //           ),
          //           SizedBox(
          //             width: 5,
          //           ),
          //           Center(
          //             child: Text(
          //               'الصور',
          //               style:  GoogleFonts.cairo(
          //                   fontSize: 12, fontWeight: FontWeight.bold),
          //             ),
          //           ),
          //         ],
          //       )),
          // ),
          Container(
            alignment: Alignment.centerLeft,
            child: Container(
//              width: MediaQuery.of(context).size.width*0.35,
              margin: EdgeInsets.symmetric(vertical: 22, horizontal: 10),
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
                        Icons.book_online,
                        size: 18,
                        color: CtmColors.appWhiteColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'حجز الان',
                        style: ctmPaymentBtnTxtStyleSize14,
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  print('token main :' + DBHelper01.getToken('token').toString());
                  print('booking process step-5');
                  if (DBHelper01.getToken('token') != null) {
                    //  Get.to(PickupAndDropPage(ticketListModel));
                    print('booking process step-5');

                    //Get.PaymentSystemPage(/login);
                    Get.to(PickupAndDropPage(ticketListModel));
                    // Get.to('/payment_system');
                    // journeyDate: selectedDateDepart.toString().substring(0, 10)));
                  } else {
                    Get.toNamed('/login');
                  }
                },
              ),
            ),
          ),

          SizedBox(height: 10),
          InkWell(
            onTap: () {
              print('Policy Click');
              _buildAlertPolicy(context);
            },
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: EdgeInsets.symmetric(vertical: 2, horizontal: 1),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.policy,
                      size: 18,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Center(
                      child: Text(
                        'السياسة',
                        style:  GoogleFonts.cairo(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
                /*Center(child: Text('Policy',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)

                )*/
                ),
          ),
          SizedBox(height: 12),
          // InkWell(
          //   onTap: () {
          //     print('Review Click ');

          //     Get.to(Reviews());
          //   },
          //   child: Container(
          //       decoration: BoxDecoration(
          //         color: Colors.grey.shade200,
          //         borderRadius: BorderRadius.circular(5),
          //       ),
          //       margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          //       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          //       child: Row(
          //         mainAxisSize: MainAxisSize.max,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Icon(
          //             Icons.reviews,
          //             size: 18,
          //             color: Theme.of(context).primaryColor,
          //           ),
          //           SizedBox(
          //             width: 5,
          //           ),
          //           Center(
          //             child: Text(
          //               'المراجعة',
          //               style:  GoogleFonts.cairo(
          //                   fontSize: 12, fontWeight: FontWeight.bold),
          //             ),
          //           ),
          //         ],
          //       )
          //       //Center(child: Text('Reviews',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),))
          //       ),
          // ),
        ],
      ),
    );
  }

  ///Right site
  _buildRightCardUI(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      // color: Colors.deepOrange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
/*
          ticketListModel.specialFair == ""
              ? Container()
              : ctmTextFormatValueRow('أجرة المقعد ', CtmStrings.currencySymbol,
                  ticketListModel.specialFair ?? '0'),

          ticketListModel.childFair == ""
              ? Container()
              : ctmTextFormatValueRow('أجرة الاطفال', CtmStrings.currencySymbol,
                  ticketListModel.childFair ?? '0'),
*/
          // ticketListModel.adultFair == ""
          //     ? Container()
          //     : ctmTextFormatValueRow('أجرة التذكرة', CtmStrings.currencySymbol,
          //         ticketListModel.adultFair ?? '0'),
          // ctmTextFormatValueRow(
          //     'مدة الرحلة', '', ticketListModel.journeyHour ?? 'ساعات' + ' '),
          // ctmTextFormatValueRow(
          // 'الوصول', '', ticketListModel.availableSeat.toString()),

          ///todo rating in future modify
          // ctmTextFormatValueRow('التقييم', '', ticketListModel.rating ?? '0.0'),

          Container(
            margin: EdgeInsets.symmetric(vertical: 22, horizontal: 10),
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
                      Icons.book_online,
                      size: 18,
                      color: CtmColors.appWhiteColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'حجز الان',
                      style: ctmPaymentBtnTxtStyleSize14,
                    ),
                  ],
                ),
              ),
              onPressed: () {
                print('token main :' + DBHelper01.getToken('token').toString());
                print('booking process step-5');
                if (DBHelper01.getToken('token') != null) {
                  //  Get.to(PickupAndDropPage(ticketListModel));
                  print('booking process step-5');

                  //Get.PaymentSystemPage(/login);
                  Get.to(PickupAndDropPage(ticketListModel));
                  // Get.to('/payment_system');
                  // journeyDate: selectedDateDepart.toString().substring(0, 10)));
                } else {
                  Get.toNamed('/login');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  ///Format Row Line Text Format
  Widget ctmTextFormatValueRow(
      String key, String currencySymbol, String value) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
      child: Row(
        children: [
          Text(
            key + ' : ',
            style:  GoogleFonts.cairo(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange),
          ),
          Text(
            style:
             GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.bold),
            currencySymbol + ' ' + value,
            maxLines: 2,
            // overflow: TextOverflow.fade,
          ),
        ],
      ),
    );
  }

  /// Alert Info  Policy
  _buildAlertPolicy(BuildContext context) {
    return showDialog(

      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(' السياسات ' ,textAlign: TextAlign.center),
        content: Text(policyString,
            style:
             GoogleFonts.cairo(fontSize: 10, fontWeight: FontWeight.bold),textAlign: TextAlign.right),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  // style: GoogleFonts.cairo(fontSize: 12,fontWeight: FontWeight.bold),
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                child: Text(
                  'أوافق',
                  style: GoogleFonts.cairo(
                      fontSize: 18, color: CtmColors.appWhiteColor),
                )),
          ),
        ],
      ),
    );
  }

  /// Bottom Sheet Review

  Widget _buildReviews() {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey.shade200,
            alignment: Alignment.center,
            child: CtmReviewCardWidget());
      },
    );
  }
}
