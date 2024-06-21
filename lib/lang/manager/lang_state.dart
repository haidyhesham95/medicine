part of 'lang_cubit.dart';

@immutable
sealed class LangState {}

final class LangInitial extends LangState {}
class ChangeLanguageState extends LangState {
  final Locale locale;

  ChangeLanguageState(
      {
        required this.locale
      }
      );
}