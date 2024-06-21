import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../manager/lang_cubit.dart';
import 'app_local.dart';

class LangDialog extends StatelessWidget {
  const LangDialog({super.key,});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<LangCubit, LangState>(
        builder: (BuildContext context, state) {
          LangCubit cubit = LangCubit.get(context);
          return AlertDialog(
            title: Center(
              child: Text(
                getLang(context, 'Change Language'),style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
              ),
            ),
            alignment: Alignment.center,
            actions: [
              Center(
                child: Container(
                  width: 140.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color:  const Color(0xFF4DA8CF).withOpacity(0.9),

                    width: 1.5,
                    ),
                    color: Colors.white
                  ),
                  child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(20),
                    icon: const Icon(Icons.language,),

                    padding: const EdgeInsets.symmetric(
                        horizontal: 15),
                    dropdownColor:  const Color(0xFF4DA8CF),

                    underline: const SizedBox(),
                    iconSize: 30,
                    isExpanded: true,
                    value: LangCubit.get(context).appLocale.languageCode,
                    items: const [
                      DropdownMenuItem(
                          value: 'en',
                          child: Text('English')),
                      DropdownMenuItem(
                          value: 'ar',
                          child: Text('اللغة العربية')),
                    ],
                    onChanged: (String? value) {
                      if (value != null) {
                        cubit.changeAppLanguage(Locale(value));
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        });




  }
}
