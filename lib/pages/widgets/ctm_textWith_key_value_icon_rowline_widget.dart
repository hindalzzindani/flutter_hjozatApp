
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CtmTextWithKeyValueIconRowLineWidget extends StatelessWidget {

  final String? ctmKey;
  final String ?ctmValue;
   Icon? ctmIcon;


  CtmTextWithKeyValueIconRowLineWidget(this.ctmKey, this.ctmValue,this.ctmIcon);

  @override
  Widget build(BuildContext context) {
    final double? wordSpacing;

    return Padding(
      padding: const EdgeInsets.only(left: 5,top: 3,bottom: 3),
      child: Row(

        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: ctmIcon!),
         // Expanded(
         //    flex: 1,
         //    child: Text(ctmKey! + '  ',
         //        style:
         //        TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),),
         //
         //  ),
          Expanded(
            flex: 6,
            child: Text(
              // style:TextStyle(letterSpacing : 2.0,),
              ctmValue!,
              maxLines: 1,
              overflow: TextOverflow.clip, style:
             GoogleFonts.cairo(),

            ),
          ),
        ],
      ),
    );

  }
}
