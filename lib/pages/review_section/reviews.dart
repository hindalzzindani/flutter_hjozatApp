
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/ctm_colors.dart';
import '../../controllers/country_controller/CountryController.dart';
import '../../pages/widgets/booking_now_card_widget.dart';
import '../../pages/widgets/ctm_drawer_widget.dart';
import '../../pages/widgets/ctm_header_widget.dart';
import 'package:get/get.dart';

import '../../common/theme_helper.dart';

import '../profile_settings/profile_page.dart';
import '../widgets/ctm_review_card_widget.dart';

class Reviews extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _ReviewsState();
  }

}

class _ReviewsState extends State<Reviews>{
  CountryController countryController =Get.put(CountryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("المراجعات ",
            style:  GoogleFonts.cairo(color: CtmColors.appWhiteColor, fontWeight: FontWeight.bold),
          ),
          elevation: 0.5,
          iconTheme: IconThemeData(color: CtmColors.appWhiteColor),),

        body: _buildReviews()
    );

  }

  Widget _buildReviews(){
    return SingleChildScrollView(
      child: Stack(
        children: [
          //Container(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Column(
              children: [
             //   SizedBox(height: 100,),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(1, 10, 1, 5),
                  padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "قائمة المراجعة ",
                          style:  GoogleFonts.cairo(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),

                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:1,
                          itemBuilder: (context,index){
                            return  CtmReviewCardWidget();

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
