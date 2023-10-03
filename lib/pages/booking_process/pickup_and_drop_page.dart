import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/ctm_alert_widget.dart';
import '../../common/ctm_back_button_widget.dart';
import '../../common/ctm_colors.dart';
import '../../common/ctm_style.dart';
import '../../controllers/booking/dynamic_seat_plan_controller.dart';
import '../../controllers/country_controller/CountryController.dart';
import '../../controllers/profile/profile_controller.dart';
import '../../models/find_tickets_trip_list_model.dart';
import '../../pages/payment_method/payment_system.dart';
import '../../pages/widgets/ctm_drawer_widget.dart';
import 'package:get/get.dart';
import '../../common/ctm_strings.dart';
import '../../common/theme_helper.dart';
import '../profile_settings/profile_page.dart';

class PickupAndDropPage extends StatefulWidget {
  FindTicketListModel ticketListModel;
  ProfileController profileController = Get.put(ProfileController());
  PickupAndDropPage(this.ticketListModel);

  @override
  State<StatefulWidget> createState() {
    return _PickupAndDropPageState();
  }
}

class _PickupAndDropPageState extends State<PickupAndDropPage>
    with TickerProviderStateMixin {
  // DynamicSeatPlanController dynamicSeatPlanController =
  //     Get.put(DynamicSeatPlanController());
  CountryController countryController = Get.put(CountryController());
  ProfileController profileController = ProfileController();
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;

  List selected = [];
  int? selectedItems;

  final listAdd = <Widget>[];
  var listAddGroup = [];

  bool isActiveSeatColor = true;

  int totalSeat = 0;
  int childrenSeatNo = 0;
  double childrenSeatFair = 0.0;
  int adultSeatNo = 0;
  double adultSeatFair = 0.0;
  int specialSeatNo = 0;
  double specialSeatFair = 0.0;
  double groupPrice = 0.0;
  double totalPrice = 0.0;

  int inputChildSeatNo = 0;
  int inputAdultSeatNo = 0;
  int inputSpecialSeatNo = 0;

  double childSeatCountWithFairCal = 0.0;
  double adultSeatCountWithFairCal = 0.0;
  double specialSeatCountWithFairCal = 0.0;

  int totalSeatNo = 0;
  int seatListLng = 0;

  TextEditingController specialTxtEditController = TextEditingController();
  TextEditingController adultTxtEditController = TextEditingController();
  TextEditingController childTxtEditController = TextEditingController();
  late AnimationController animationController;

  @override
  void initState() {
    animationRepeat();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }

  animationRepeat() {
    animationController = new AnimationController(
      duration: new Duration(seconds: 5),
      vsync: this,
    );
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    FindTicketListModel bookInfo = widget.ticketListModel;

    print("bookInfo:${bookInfo}");

    ///----------------- Children info --------------------

    if (bookInfo.childSeat.toString() != '' && bookInfo.childSeat != null) {
      childrenSeatNo = int.parse(bookInfo.childSeat.toString());
    }
    if (bookInfo.childFair.toString() != '' && bookInfo.childFair != null) {
      childrenSeatFair = double.parse(bookInfo.childFair.toString());
    }

    ///----------------- Adult info --------------------
    adultSeatFair = double.parse(bookInfo.adultFair.toString());

    if (bookInfo.childSeat.toString() != '') {
      // adultSeatNo=int.parse(bookInfo.adult.toString());
    }
    if (bookInfo.childFair.toString() != '') {
      adultSeatFair = double.parse(bookInfo.adultFair.toString());
    }

    ///----------------- Special info --------------------

    if (bookInfo.childSeat.toString() != '' && bookInfo.childSeat != null) {
      specialSeatNo = int.parse(bookInfo.specialSeat.toString());
    }
    if (bookInfo.childFair.toString() != '' && bookInfo.childFair != null) {
      specialSeatFair = double.parse(bookInfo.specialFair.toString());
    }

    print(String.fromCharCode(65));

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "متابعة الحجز ",
              style:  GoogleFonts.cairo(
                  color: CtmColors.appWhiteColor, fontWeight: FontWeight.bold),
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
          body: SingleChildScrollView(child: _buildPickDropForm()),
          bottomNavigationBar: _buildBtn(),
        ));
  }

  _buildPickDropForm() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CtmBackButtonWidget(),
            SizedBox(
              height: 5,
            ),
/*
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    readOnly: true,
                    enableInteractiveSelection: true,
                    controller: childTxtEditController,
                    onChanged: (childrenValue) {
                      String val = childrenValue;
                      if (val.isEmpty) {
                        setState(() {
                          print('cal child +');
                          childSeatCountWithFairCal =
                              (double.parse(inputChildSeatNo.toString())) *
                                  childrenSeatFair;
                          inputChildSeatNo = 1;
                          totalPrice = adultSeatCountWithFairCal;
                        });
                      } else {
                        inputChildSeatNo = int.parse(childrenValue.toString());

                        if (inputChildSeatNo <= selected.length) {
                          setState(() {
                            adultSeatCountWithFairCal =
                                (double.parse(inputChildSeatNo.toString())) *
                                    childrenSeatFair;
                            totalPrice += adultSeatCountWithFairCal;
                          });
                          print('child Total Price  :' +
                              childSeatCountWithFairCal.toString());
                        }
                        //احتساب السعر
                        else {
                          Get.snackbar(
                              'تنبيه', 'يجب أن يتساوى عددالمقاعد مع التحديد');
                          print('cal Adult +');
                          setState(() {
                            adultSeatCountWithFairCal = 1 * childrenSeatFair;
                            inputChildSeatNo = 1;
                            totalPrice = childSeatCountWithFairCal;
                          });
                        }
                      }
                    },
                    decoration: ThemeHelper()
                        .textInputDecoration("أطفال", "رقم المقعد"),
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      return "Enter a valid number";
                    },
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: adultTxtEditController,
                    onChanged: (adultValue) {
                      String val = adultValue;
                      if (val.isEmpty) {
                        setState(() {
                          print('cal Adult +');
                          adultSeatCountWithFairCal =
                              (double.parse(inputAdultSeatNo.toString())) *
                                  adultSeatFair;
                          inputAdultSeatNo = 1;
                          totalPrice = adultSeatCountWithFairCal;
                        });
                      } else {
                        inputAdultSeatNo = int.parse(adultValue.toString());
                        if (inputAdultSeatNo <= selected.length) {
                          setState(() {
                            adultSeatCountWithFairCal =
                                (double.parse(inputAdultSeatNo.toString())) *
                                    adultSeatFair;
                            totalPrice += adultSeatCountWithFairCal;
                          });
                          print('adult Total Price  :' +
                              adultSeatCountWithFairCal.toString());
                        }
                        // else {
                        //   Get.snackbar('Alert',
                        //       'Select item equal or less then seat count');
                        //   print('cal Adult +');
                        //   setState(() {
                        //     adultSeatCountWithFairCal = 0 * adultSeatFair;
                        //     inputAdultSeatNo = 0;
                        //     totalPrice -= adultSeatCountWithFairCal;
                        //   });
                        // }
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: ThemeHelper()
                        .textInputDecoration('بالغين', 'رقم المقعد'),
                  ),
                ),
                SizedBox(width: 2.0),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    readOnly: true,
                    // enableInteractiveSelection: true,
                    onChanged: (specialValue) {
                      String val = specialValue;
                      if (val.isEmpty) {
                        setState(() {
                          print('cal special +');
                          specialSeatCountWithFairCal =
                              (double.parse(inputSpecialSeatNo.toString())) *
                                  specialSeatFair;
                          inputSpecialSeatNo = 1;
                          totalPrice = specialSeatCountWithFairCal;
                        });
                      } else {
                        inputSpecialSeatNo = int.parse(specialValue.toString());

                        if (inputSpecialSeatNo <= selected.length) {
                          setState(() {
                            specialSeatCountWithFairCal =
                                (double.parse(inputSpecialSeatNo.toString())) *
                                    specialSeatFair;
                            totalPrice += specialSeatCountWithFairCal;
                          });
                        } else {
                          // Get.snackbar('تنبيه', 'ادحل  عدد المسافرين ');
                          // print('cal Adult +');
                          setState(() {
                            specialSeatCountWithFairCal = 0 * specialSeatFair;
                            inputSpecialSeatNo = 0;
                            totalPrice = specialSeatCountWithFairCal;
                          });
                        }
                      }
                    },
                    decoration:
                        ThemeHelper().textInputDecoration('خاص', 'رقم المقعد'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
*/
            _buildSeatPlan(),
            _buildBtn2(),
          ],
        ),
      ),
    );
  }

  //
  Widget _buildSeatPlan() {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(5, 1, 5, 0),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(1, 1, 0, 0),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Column(
                    children: <Widget>[
/*
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  ' اجمالي المقاعد: ' +
                                      widget.ticketListModel.totalSeat
                                          .toString(),
                                  style:  GoogleFonts.cairo(
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                child: AnimatedBuilder(
                                  animation: animationController,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 2, top: 2, right: 5),
                                      child: Image.asset(
                                        CtmStrings.driverStaringImagePNGPath,
                                        width: 60,
                                        height: 60,
                                      ),
                                    ),
                                  ),
                                  builder:
                                      (BuildContext? context, Widget? _widget) {
                                    return Transform.rotate(
                                      angle: animationController.value *
                                          2 *
                                          3.14159265,
                                      child: _widget,
                                    );
                                  },
                                ),
                              ))
                        ],
                      ),
*/
                      // dynamicSeatLayout(),
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

  ///---------------------- Dynamic Seat Layout -----------
  //
  // dynamicSeatLayout() {
  //   return Obx(() {
  //     if (dynamicSeatPlanController.seats.length != 0) {
  //       return Text('ليس مقعدا ');
  //     } else {
  //       List layout = dynamicSeatPlanController.seats;
  //       return Container(
  //         padding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
  //         child: Column(
  //           children: layout.map((col) {
  //             List items = col;
  //             return Row(
  //               children: items.map((row) {
  //                 if (row != null) {
  //                   return Padding(
  //                     padding: const EdgeInsets.all(2.0),
  //                     child: TextButton(onPressed: () {}, child: Text('')),
  //                   );
  //                 } else {
  //                   return Expanded(
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(2.0),
  //                       child: InkWell(
  //                         onTap: () {
  //                           /// Setting Part Fetch Data
  //                           CtmStrings.currencySymbol.toString();
  //                           String maxSeatNo = CtmStrings.maxTicket;
  //                           print('maxSeatNo :' + maxSeatNo);
  //
  //                           setState(() {
  //                             /// Setting Info
  //
  //                             print('selectedSeatLng:' +
  //                                 selected.length.toString());
  //                             int selectSeatLng = selected.length;
  //
  //                             if (selected.contains(row['seatNumber'])) {
  //                               selected.remove(row['seatNumber']);
  //                             } else {
  //                               if (selectSeatLng <
  //                                   int.parse(CtmStrings.maxTicket)) {
  //                                 if (row['isReserved'] != true) {
  //                                   selected.add(row['seatNumber']);
  //                                 }
  //                               } else {
  //                                 CtmAlertDialog.fieldAlertDialog(
  //                                     CtmStrings.fieldAlert,
  //                                     CtmStrings.fieldAlertSeatAtATimeMessage);
  //                               }
  //                             }
  //
  //                             print(
  //                                 'items :' + jsonEncode(selected.toString()));
  //                           });
  //                         },
  //                         child: Stack(
  //                           children: [
  //                             Container(
  //                               color: (selected.contains(row['seatNumber']) ||
  //                                       row['isReserved'] != true)
  //                                   ? Colors.grey
  //                                   : Colors.green.shade50,
  //                               margin: EdgeInsets.symmetric(
  //                                   vertical: 5, horizontal: 2),
  //                               padding: EdgeInsets.symmetric(
  //                                   vertical: 2, horizontal: 0),
  //                               height: 50,
  //                               width: 50,
  //                               child: Image.asset(CtmStrings.seatImagePNGPath,
  //                                   height: 50,
  //                                   width: 50,
  //                                   color:
  //                                       (selected.contains(row['seatNumber']) ||
  //                                               row['isReserved'] != true)
  //                                           ? Colors.grey
  //                                           : Colors.green),
  //                             ),
  //                             Positioned(
  //                                 left: 18,
  //                                 top: 15,
  //                                 child: Text(row['seatNumber']))
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 }
  //               }).toList(),
  //             );
  //           }).toList(),
  //         ),
  //       );
  //     }
  //   });
  // }

  _textformat({ctmKey, ctmValue}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: Text(ctmKey!,
                style:  GoogleFonts.cairo(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 1,
            child: Text(
              " : " + ctmValue!,
              maxLines: 4,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }

  _buildBtn2() {
    return Card(
      borderOnForeground: true,
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.fromLTRB(30, 0, 20, 0),
            height: 130,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
/*
                _textformat(
                    ctmKey: "سعر خاص", ctmValue: specialSeatFair.toString()),
*/
                _textformat(
                    ctmKey: "السعر للبالغين",
                    ctmValue: adultSeatFair.toString()),
/*
                _textformat(
                    ctmKey: "السعر للاطفال",
                    ctmValue: childrenSeatFair.toString()),
*/
                Divider(
                  height: 10,
                  thickness: 1.5,
                ),
                _textformat(
                    ctmKey: "اجمالي السعر", ctmValue: adultSeatFair.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildBtn() {
    return Card(
      borderOnForeground: true,
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
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
                      'استمرار في  الحجز',
                      style: ctmPaymentBtnTxtStyle,
                    ),
                  ],
                ),
              ),
              onPressed: () {
                Map<String, dynamic> bookingInfoBodyMap = {
                  'aseat': inputAdultSeatNo.toString(),
                  'cseat': inputChildSeatNo.toString(),
                  'spseat': inputSpecialSeatNo.toString(),
                  'vehicle_id': '1',
                  // 'seatnumbers': selected, //[A1,A2]
                  'totalseat': totalSeatNo.toString(),
                  'partialpay': '0',
                  'totalprice': adultSeatFair.toString(),
                  'vehicle_id': widget.ticketListModel.vehicleId.toString()
                };

                print('booking process step-5');
                Get.to(PaymentSystemPage(
                    widget.ticketListModel, bookingInfoBodyMap));
                totalSeatNo =
                    inputChildSeatNo + inputAdultSeatNo + inputSpecialSeatNo;
                seatListLng = selected.length;
                //من هنا خاصية الانتقال للصفحة التاليه
                if (seatListLng == 0) {
                  if (totalSeatNo != seatListLng) {}
                  // else
                  // {
                  //   Get.snackbar('تنبيه',
                  //       ''' يجب ان يكون الاختيار مساوى لواحد أو أكثر''',
                  //       backgroundColor: CtmColors.appWhiteColor,
                  //       colorText: CtmColors.appRedColor);
                  // }
                }
                // else {
                //   Get.snackbar(
                //       'تنبيه', ''' يجب ان يكون الاختيار واحد أو أكثر''',
                //       backgroundColor: CtmColors.appWhiteColor,
                //       colorText: CtmColors.appRedColor);
                // }
              },
            ),
          ),
        ],
      ),
    );
  }
}
