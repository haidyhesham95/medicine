import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/cache_helper.dart';
import 'package:pharmacy/core/kiwi.dart';
import 'package:pharmacy/firebase_options.dart';
import 'package:pharmacy/views/auth/cheackuser.dart';

import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'lang/manager/lang_cubit.dart';
import 'lang/widget/app_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  await initKiwi();
  await CacheHelper.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key, });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [

          BlocProvider<LangCubit>(
            create: (context) => LangCubit( ),
          ),
        ],
        child: BlocConsumer<LangCubit, LangState>(
        listener: (context, state) {},
    builder: (context, state) {
      return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
            ),
            locale: LangCubit.get(context).appLocale,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AppLocale.delegate
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            localeResolutionCallback: ((crlocales, supportedLocales) {
              if (crlocales != null) {
                for (Locale locale in supportedLocales) {
                  if (locale.languageCode == crlocales.languageCode) {
                    return locale;
                  }
                }
              }
              return supportedLocales.first;
            }),
            home: CheackUser(),
          );
        },
      );
    },
      ),
    );
  }
}
