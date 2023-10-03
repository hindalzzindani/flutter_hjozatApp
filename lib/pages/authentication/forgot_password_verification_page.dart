import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/ctm_colors.dart';
import '../../common/theme_helper.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../profile_settings/profile_page.dart';
import '../widgets/ctm_header_widget.dart';

class ForgotPasswordVerificationPage extends StatefulWidget {
  const ForgotPasswordVerificationPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordVerificationPageState createState() => _ForgotPasswordVerificationPageState();
}

class _ForgotPasswordVerificationPageState extends State<ForgotPasswordVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  bool _pinSuccess = false;

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 300;

    return Scaffold(
        backgroundColor: CtmColors.appWhiteColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: _headerHeight,
                child: HeaderWidget(
                    _headerHeight, true, Icons.privacy_tip_outlined),
              ),
              SafeArea(
                child: Container(
                  margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('التحقق',
                              style:  GoogleFonts.cairo(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54
                              ),
                              // textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            Text(
                              'أدخل كود التحقق المرسل الى بريدك الالكتروني.',
                              style:   GoogleFonts.cairo(
                                // fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54
                              ),
                              // textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            OTPTextField(
                              length: 4,
                              width: 300,
                              fieldWidth: 50,
                              style:   GoogleFonts.cairo(
                                  fontSize: 30
                              ),
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldStyle: FieldStyle.underline,
                              onCompleted: (pin) {
                                setState(() {
                                  _pinSuccess = true;
                                });
                              },
                            ),
                            SizedBox(height: 50.0),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "لم لصلك الكود! ",
                                    style:   GoogleFonts.cairo(
                                      color: Colors.black38,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'اعادة ارسال',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ThemeHelper().alartDialog("Successful",
                                                "Verification code resend successful.",
                                                context);
                                          },
                                        );
                                      },
                                    style:   GoogleFonts.cairo(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40.0),
                            Container(
                              decoration: _pinSuccess ? ThemeHelper().buttonBoxDecoration(context):ThemeHelper().buttonBoxDecoration(context, "#AAAAAA","#757575"),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(context),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text(
                                    "تحقق".toUpperCase(),
                                    style:   GoogleFonts.cairo(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: CtmColors.appWhiteColor,
                                    ),
                                  ),
                                ),
                                onPressed: _pinSuccess ? () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => ProfilePage()
                                      ),
                                          (Route<dynamic> route) => false
                                  );
                                } : null,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
