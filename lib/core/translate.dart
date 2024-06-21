import 'package:translator/translator.dart';

class Translate {
  static Future<String> translate(String text) async {
    final translator = GoogleTranslator();
    var translated = await translator.translate(text, from: 'en', to: 'ar');
    return translated.text;
  }
}
