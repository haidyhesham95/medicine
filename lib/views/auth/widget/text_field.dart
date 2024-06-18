import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextFormField textField(context,String? hintText,TextEditingController? controller,String? Function(String?)? validator){
   return TextFormField(
    controller: controller,
    validator:validator,
    decoration: InputDecoration(
      hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black26,
        ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular( 15.r),
        borderSide: BorderSide(
          color: Color(0xFF4E97C5),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular( 15.r),
        borderSide: BorderSide(
          color: Color(0xFF4E97C5),
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular( 15.r),
        borderSide: BorderSide(
          color: Color(0xFF4E97C5),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular( 15.r),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular( 15.r),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
    ),
  );
}