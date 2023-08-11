const String ARABIC = 'ar';
const String ENGLISH = 'en';

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
