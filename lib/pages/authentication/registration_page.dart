import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/ctm_alert_widget.dart';
import '../../common/ctm_colors.dart';
import '../../common/ctm_strings.dart';
import '../../common/ctm_style.dart';
import '../../common/theme_helper.dart';
import '../../pages/authentication/login_page.dart';
import '../../pages/widgets/ctm_header_widget.dart';
import '../../repository/auth_repository.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import '../../controllers/country_controller/CountryController.dart';
import '../company_info/terms_condition_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  // final int maxWordLength;
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  CountryController countryController = Get.put(CountryController());

  TextEditingController loginEmailEController = TextEditingController();
  TextEditingController loginMobileEController = TextEditingController();
  TextEditingController passEController = TextEditingController();
  TextEditingController rePassEController = TextEditingController();
  TextEditingController firstNameEController = TextEditingController();
  TextEditingController lastNameEController = TextEditingController();
  TextEditingController idTypeEController = TextEditingController();
  TextEditingController idNumberEController = TextEditingController();

  String loginEmail = '';
  String loginMobile = '';
  String password = '';
  String rePassword = '';
  String firstName = '';
  String lastName = '';
  String idType = 'رقم الهوية';
  String idNumber = '';
  String countryId = "1";
  late ProgressDialog pr;
  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context);
    pr.style(
        message: 'انتظرقليلا ...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle:  GoogleFonts.cairo(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle:  GoogleFonts.cairo(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: CtmColors.appBgColor,
          //Colors.white,
          body: _buildRegBody(),
        ));
  }

  Widget _buildRegBody() {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: 300,
            child: HeaderWidget(90, false, Icons.person_add_alt_1_rounded),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            alignment: Alignment.center,
            child: _buildRegForm(),
          ),
        ],
      ),
    );
  }

  _buildRegForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            CtmStrings.signUp,
            style:  GoogleFonts.cairo(
                color: Color.fromARGB(255, 2, 64, 221),
                fontSize: 16,
                fontWeight: FontWeight.w500),
            //
            // style: ctmSignUpTxtStyle,
          ),

          SizedBox(
            height: 60,
          ),
          Text(
            CtmStrings.signUpBelowText,
            style:  GoogleFonts.cairo(fontSize: 10),
            //
            // style: TextStyle(fontSize: 10),
          ),

          SizedBox(
            height: 10,
          ),
          Container(
            child: TextFormField(
              controller: firstNameEController,
              decoration: ThemeHelper().textInputDecoration(
                  CtmStrings.regFirstName, CtmStrings.enterYFirstName),
              style:  GoogleFonts.cairo(
                  color: Colors.black38,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
              validator: (value) {
                if (value == null || value!.length < 15) {
                  return 'يرجى إدخال الاسم الرباعي';
                }
                return null;
              },
            ),
            decoration: ThemeHelper().inputBoxDecorationShaddow(),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: TextFormField(
              controller: lastNameEController,
              decoration: ThemeHelper().textInputDecoration(
                  CtmStrings.regLastName, CtmStrings.enterYLastName),
              style:  GoogleFonts.cairo(
                  color: Colors.black38,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
            decoration: ThemeHelper().inputBoxDecorationShaddow(),
          ),
          SizedBox(height: 10.0),
          Container(
            child: TextFormField(
              controller: loginEmailEController,
              decoration: ThemeHelper().textInputDecoration(
                  CtmStrings.regEmailAddressMust, CtmStrings.enterYMail),
              keyboardType: TextInputType.emailAddress,
              validator: (val) {
                if ((val!.isEmpty) &&
                    !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                        .hasMatch(val)) {
                  return CtmStrings.plzEnterValidMail;
                }
                return null;
              },
              style:  GoogleFonts.cairo(
                  color: Colors.black38,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
            decoration: ThemeHelper().inputBoxDecorationShaddow(),
          ),

          SizedBox(height: 10.0),

          /// Document drop down type
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  //  height: 50,
                  //width: 100,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 1, color: Colors.black.withOpacity(0.2)),
                    color: CtmColors.appWhiteColor,
                  ),
                  child: _docTpe(),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                flex: 4,
                child: Container(
                  child: TextFormField(
                    style:  GoogleFonts.cairo(
                        color: Colors.black38,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    controller: idNumberEController,
                    decoration: ThemeHelper().textInputDecoration(
                        CtmStrings.regDocNo, CtmStrings.enterYDoc),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      return null;
                    },
                  ),
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                ),
              ),
            ],
          ),

          SizedBox(height: 10.0),

          SizedBox(height: 10.0),
          Container(
            child: TextFormField(
              style:  GoogleFonts.cairo(
                  color: Colors.black38,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
              controller: loginMobileEController,
              decoration: ThemeHelper().textInputDecoration(
                  CtmStrings.regMobileNumberMust,
                  CtmStrings.enterYMobileNumber),
              keyboardType: TextInputType.phone,
              validator: (val) {
                if ((val!.isEmpty) && !RegExp(r"^(219").hasMatch(val)) {
                  return CtmStrings.plzEnterValidPhone;
                }
                return null;
              },
            ),
            decoration: ThemeHelper().inputBoxDecorationShaddow(),
          ),
          SizedBox(height: 10.0),
          Container(
            child: TextFormField(
              controller: passEController,
              obscureText: true,
              decoration: ThemeHelper().textInputDecoration(
                  CtmStrings.regPassMust, CtmStrings.enterYPassword),
              validator: (val) {
                if (val!.isEmpty) {
                  return CtmStrings.plzEnterYPassword;
                }
                return null;
              },
            ),
            decoration: ThemeHelper().inputBoxDecorationShaddow(),
          ),
          SizedBox(height: 10.0),
          Container(
            child: TextFormField(
              style:  GoogleFonts.cairo(
                  color: Colors.black38,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
              obscureText: true,
              controller: rePassEController,
              decoration: ThemeHelper().textInputDecoration(
                  CtmStrings.regRePassMust, CtmStrings.enterYPassword),
              validator: (val) {
                if (val!.isEmpty) {
                  return CtmStrings.plzEnterYPassword;
                }
                return null;
              },
            ),
            decoration: ThemeHelper().inputBoxDecorationShaddow(),
          ),
          SizedBox(height: 10.0),

          Container(
            height: 50,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                )
              ],
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(width: 1, color: Colors.black.withOpacity(0.2)),
              color: CtmColors.appWhiteColor,
            ),
            child: _countryListTo(),
          ),

          SizedBox(height: 10.0),
          FormField<bool>(
            builder: (state) {
              return Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Checkbox(
                            value: checkboxValue,
                            onChanged: (value) {
                              setState(() {
                                checkboxValue = value!;
                                state.didChange(value);
                              });
                            }),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          CtmStrings.regIAcceptTermsConditions,
                          style:  GoogleFonts.cairo(
                              color: Colors.grey, fontSize: 12),
                          //
                          // style: TextStyle(color: Colors.grey,fontSize: 12),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.to(TermsAndConditionPage());
                          },
                          child: Text(
                            " الشروط",
                            style:  GoogleFonts.cairo(
                                color: Theme.of(context).primaryColor,
                                fontStyle: FontStyle.italic),
                            //
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      state.errorText ?? '',
                      textAlign: TextAlign.left,
                      style:  GoogleFonts.cairo(
                          color: Theme.of(context).errorColor, fontSize: 12),
                    ),
                  )
                ],
              );
            },
            validator: (value) {
              if (!checkboxValue) {
                return CtmStrings.regNeedAcceptTermsConditions;
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 5.0),

          /// Register Button
          _buildButtonReg(),
          SizedBox(height: 10.0),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
            //child: Text('Don\'t have an account? Create'),
            child: Text.rich(TextSpan(
                style:  GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(text: "لديك حساب? "), //
                  TextSpan(
                    text: ' تسجيل الدخول',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                    style:  GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary),
                  )
                ])),
          ),
        ],
      ),
    );
  }

  /// Location form country id

  _countryListTo() {
    return Obx(() {
      return DropdownButton(
        underline: SizedBox(),
        isDense: true,
        isExpanded: true,
        value: countryId,
        items: countryController.countryList.map((country) {
          return DropdownMenuItem(
            child: Text(
              country.name.toString(),
              style:  GoogleFonts.cairo(
                  fontSize: 12,
                  color: Color.fromARGB(255, 4, 117, 204),
                  fontWeight: FontWeight.bold),
            ),
            value: country.id,
          );
        }).toList(),
        onChanged: (countryToId) {
          countryId = countryToId.toString();
          setState(() {});
          print("You selected To: $countryToId");
        },
      );
    });
  }

  _docTpe() {
    return Obx(() {
      return DropdownButton(
        underline: SizedBox(),
        isDense: true,
        isExpanded: true,
        value: idType,
        items: countryController.docType.map((type) {
          return DropdownMenuItem(
            child: Text(
              type.name.toString(),
              style:  GoogleFonts.cairo(
                  fontSize: 12, color: Colors.grey.shade700),
            ),
            value: type.name,
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            idType = newValue!;
            print("You selected type id : $idType");
          });
        },
        // onChanged: (idType) {
        //   idType = idType.toString();
        //   setState(() {});
        //   print("You selected type id : $idType");
        // },
      );
    });
  }

  /// Button Register
  _buildButtonReg() {
    return Container(
      decoration: ThemeHelper().buttonBoxDecoration(context),
      child: ElevatedButton(
        style: ThemeHelper().buttonStyle(context),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
          child: Text(
            CtmStrings.register.toUpperCase(),
            style: ctmPaymentBtnTxtStyle,
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();

            firstName = firstNameEController.text;
            lastName = lastNameEController.text;
            loginEmail = loginEmailEController.text;
            loginMobile = loginMobileEController.text;
            idNumber = idNumberEController.text;
            password = passEController.text;
            rePassword = rePassEController.text;

            Map<String, dynamic> regBodyMap = {
              "login_email": loginEmail,
              "login_mobile": loginMobile,
              "password": password,
              "repassword": rePassword,
              "first_name": firstName,
              "last_name": lastName,
              "id_type": idType,
              "id_number": idNumber,
              "country_id": countryId,
            };
            pr.show();
            AuthRepository().registerRep(regBodyMap).then((value) {
              var bodyMap = json.decode(value.body);
              print('Login bodyMap ' + bodyMap.toString());
              var resCode = value.statusCode;
              if (resCode == 200 || resCode == 201 || resCode == 202) {
                if (bodyMap['status'] == "success") {
                  if (bodyMap['response'] == 200) {
                    if (bodyMap['data'] != null) {
                      print(bodyMap['data']);
                      var regData = bodyMap['data'];
                      print('Register Success :' + regData.toString());
                      pr.hide();
                      CtmAlertDialog.successAlertDialog(
                          'تم الاشتراك بنجاح : ', 'يرجى تسجيل الدخول');
                      Get.offAllNamed('/login');
                    }
                  }
                  CtmAlertDialog.apiServerErrorAlertDialog('تنبيه  :', '');
                  pr.hide();
                } else {
                  if (bodyMap["response"] == 404) {
                    Map errorData = bodyMap["error"];
                    errorData.forEach((key, value) {
                      CtmAlertDialog.apiServerErrorAlertDialog(
                          'تنبيه :', value.toString());
                    });
                  } else {
                    CtmAlertDialog.apiServerErrorAlertDialog(
                        'تنبيه :', 'غير متصل');
                  }
                  pr.hide();
                }
              } else {
                CtmAlertDialog.apiServerErrorAlertDialog(
                    ' :', bodyMap['غير متصل']);
                pr.hide();
              }
            }).onError((error, stackTrace) {
              CtmAlertDialog.apiServerErrorAlertDialog(
                  'غير متصل:', error.toString());
              pr.hide();
            });
          }
        },
      ),
    );
  }
}
