// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homeNavbarTitle => 'Home';

  @override
  String get parittaNavbarTitle => 'Paritta';

  @override
  String get guideNavbarTitle => 'Guide';

  @override
  String get settingNavbarTitle => 'Setting';

  @override
  String get homeLastRead => 'Last Read';

  @override
  String get homeFavorite => 'Favorite';

  @override
  String get homeNoLastReadParitta => 'Start reading a Paritta to see it here';

  @override
  String get homeNoFavoriteParitta => 'Your favorite Parittas will appear here';

  @override
  String homeDate(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMEEEEd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String get parittaSearchParitta => 'Cari Paritta';

  @override
  String get setting => 'Setting';

  @override
  String get settingCommon => 'Common';

  @override
  String get settingLanguage => 'Language';

  @override
  String get settingChooseLanguage => 'Choose Language';

  @override
  String get settingDisplay => 'Display';

  @override
  String get settingTheme => 'Theme';

  @override
  String get settingChooseTheme => 'Choose Theme';

  @override
  String get settingLight => 'Light';

  @override
  String get settingDark => 'Dark';

  @override
  String get settingSystem => 'System';

  @override
  String get settingMiscellaneous => 'Miscellaneous';

  @override
  String get settingAbout => 'About';

  @override
  String get read => 'Read';

  @override
  String get fontSize => 'Font Size';
}
