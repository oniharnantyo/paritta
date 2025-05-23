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
  String get homeNoLastReadParitta => 'Mulai baca Paritta untuk melihat disini';

  @override
  String get homeNoFavoriteParitta =>
      'Paritta favorit Anda akan muncul di sini';

  @override
  String homeDate(DateTime date) {
    final intl.DateFormat dateDateFormat =
        intl.DateFormat.yMMMMEEEEd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String get parittaSearchParitta => 'Cari Paritta';

  @override
  String get setting => 'Pengaturan';

  @override
  String get settingCommon => 'Umum';

  @override
  String get settingLanguage => 'Bahasa';

  @override
  String get settingChooseLanguage => 'Pilih Bahasa';

  @override
  String get settingDisplay => 'Tampilan';

  @override
  String get settingTheme => 'Tema';

  @override
  String get settingChooseTheme => 'Pilih Tema';

  @override
  String get settingLight => 'Terang';

  @override
  String get settingDark => 'Gelap';

  @override
  String get settingSystem => 'Sistem';

  @override
  String get settingNotification => 'Notifikasi';

  @override
  String get settingNotificationUposathaReminder => 'Pengingat Uposatha';

  @override
  String get settingMiscellaneous => 'Lain-lain';

  @override
  String get settingAbout => 'Tentang';

  @override
  String get notificationUposatha => 'Pengingat Uposatha';

  @override
  String get notificationUposathaDescription =>
      'Mari melaksanakan Uposatha Sila di hari Uposatha!';

  @override
  String get read => 'Baca';

  @override
  String get fontSize => 'Ukuran Font';
}
