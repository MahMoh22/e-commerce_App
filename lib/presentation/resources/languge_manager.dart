import 'package:flutter/material.dart';

const String ARABIC = 'ar';
const String ENGLISH = 'en';
const String ASSETS_PATH_LOCALIZATIONS = 'assets/translations';

const Locale ARABIC_LOCALE = Locale('ar', 'SA');
const Locale ENGLISH_LOCALE = Locale('en', 'US');

enum LanguageType { ARABIC, ENGLISH }

extension LanguageTypeExtention on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ARABIC:
        return ARABIC;
      case LanguageType.ENGLISH:
        return ENGLISH;
    }
  }
}
