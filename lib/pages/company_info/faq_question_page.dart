
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/company_info/company_info_controller.dart';
import '../../models/company_info_model.dart';
import 'package:get/get.dart';

class FAQQuestionPage extends StatefulWidget {
  const FAQQuestionPage({Key? key}) : super(key: key);

  @override
  State<FAQQuestionPage> createState() => _FAQQuestionPageState();
}

class _FAQQuestionPageState extends State<FAQQuestionPage> {
  CompanyInfoController companyInfoController=Get.put(CompanyInfoController());
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child:Scaffold(
      appBar: AppBar(

        title: Text('أسئلة شائعة', style:
         GoogleFonts.cairo(color: Colors.black45,)),),
      body: Obx(() {
        if(companyInfoController.isDataLoadingQA.value){
          if (companyInfoController.companyFAQQuestionList.length == 0) {
            return Center(child: Text('لايوجد بيانات!', style:
             GoogleFonts.cairo(color: Colors.black45,),));
          } else {
            return
               ListView.builder(
                  scrollDirection: Axis.vertical,
                   itemCount:companyInfoController.companyFAQQuestionList.length ,
                   itemBuilder: (BuildContext context ,int index){
                  return _buildCompanyInfoCard(companyInfoController.companyFAQQuestionList[index]);
               });
          }
        } else{
          return Center(child: CircularProgressIndicator());
        }
      })
    ));
  }
  _buildCompanyInfoCard(CompanyInfoModel companyInfo){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            Text(companyInfo.question.toString(),style:  GoogleFonts.cairo(fontSize: 20,fontWeight: FontWeight.bold),),
            Text(companyInfo.createdAt.toString(),style:  GoogleFonts.cairo(fontStyle: FontStyle.italic),),
            Padding(
              padding: const EdgeInsets.only(left: 0,top: 10,right: 10),
              child: Html(data: companyInfo.description.toString()),
            ),
          ],
        ),
      ),
    );
  }

}
