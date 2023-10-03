import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/company_info/company_info_controller.dart';
import '../../models/company_info_model.dart';
import 'package:get/get.dart';

class TermsAndConditionPage extends StatefulWidget {
  const TermsAndConditionPage({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionPage> createState() => _TermsAndConditionPageState();
}

class _TermsAndConditionPageState extends State<TermsAndConditionPage> {
  CompanyInfoController companyInfoController =
      Get.put(CompanyInfoController());
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'الشروط والاحكام',
              style:  GoogleFonts.cairo(color: Colors.black45),
            ),
          ),
          body: Obx(() {
            if (companyInfoController.isDataLoadingTerms.value) {
              CompanyInfoModel companyInfo =
                  companyInfoController.companyTerms.value;
              return _buildCompanyInfoCard(companyInfo);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
        ));
  }

  _buildCompanyInfoCard(CompanyInfoModel companyInfo) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text(
            //   companyInfo.title.toString(),
            //   style:  GoogleFonts.cairo(
            //       fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            // Text(
            //   companyInfo.createdAt.toString(),
            //   style:  GoogleFonts.cairo(fontStyle: FontStyle.italic),
            // ),
            DefaultTextStyle.merge(
              style: GoogleFonts.cairo(color: Color.fromARGB(255, 206, 37, 37)),
              child: Html(data: companyInfo.description.toString()),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, top: 10, right: 10),
              child: Html(data: companyInfo.description.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
