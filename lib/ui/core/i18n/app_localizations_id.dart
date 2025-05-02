// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get homeNavbarTitle => 'Beranda';

  @override
  String get parittaNavbarTitle => 'Paritta';

  @override
  String get guideNavbarTitle => 'Panduan';

  @override
  String get settingNavbarTitle => 'Pengaturan';

  @override
  String get homeLastRead => 'Terakhir Dibaca';

  @override
  String get homeFavorite => 'Favorit';

  @override
  String homeDate(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMEEEEd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }
}
