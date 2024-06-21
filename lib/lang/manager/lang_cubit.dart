import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'lang_state.dart';

class LangCubit extends Cubit<LangState> {
  LangCubit() : super(LangInitial());

  static LangCubit get(context) => BlocProvider.of(context);

  final String _localeKey = 'app_locale';
  late SharedPreferences _prefs;

  Locale appLocale = const Locale("en");

  Future<void> initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    final String? savedLocale = _prefs.getString(_localeKey);
    if (savedLocale != null) {
      appLocale = Locale(savedLocale);
      emit(ChangeLanguageState(locale: appLocale));
    }
  }

  void changeAppLanguage(Locale locale) async {
    appLocale = locale;
    emit(ChangeLanguageState(locale: locale));
    await _prefs.setString(_localeKey, locale.languageCode);
  }
}

