import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'i18n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id')
  ];

  /// No description provided for @homeNavbarTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeNavbarTitle;

  /// No description provided for @parittaNavbarTitle.
  ///
  /// In en, this message translates to:
  /// **'Paritta'**
  String get parittaNavbarTitle;

  /// No description provided for @guideNavbarTitle.
  ///
  /// In en, this message translates to:
  /// **'Guide'**
  String get guideNavbarTitle;

  /// No description provided for @settingNavbarTitle.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get settingNavbarTitle;

  /// No description provided for @homeLastRead.
  ///
  /// In en, this message translates to:
  /// **'Last Read'**
  String get homeLastRead;

  /// No description provided for @homeFavorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get homeFavorite;

  /// No description provided for @homeNoLastReadParitta.
  ///
  /// In en, this message translates to:
  /// **'Start reading a Paritta to see it here'**
  String get homeNoLastReadParitta;

  /// No description provided for @homeNoFavoriteParitta.
  ///
  /// In en, this message translates to:
  /// **'Your favorite Parittas will appear here'**
  String get homeNoFavoriteParitta;

  /// No description provided for @homeDate.
  ///
  /// In en, this message translates to:
  /// **'{date}'**
  String homeDate(DateTime date);

  /// No description provided for @parittaSearchParitta.
  ///
  /// In en, this message translates to:
  /// **'Cari Paritta'**
  String get parittaSearchParitta;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @settingCommon.
  ///
  /// In en, this message translates to:
  /// **'Common'**
  String get settingCommon;

  /// No description provided for @settingLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingLanguage;

  /// No description provided for @settingChooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get settingChooseLanguage;

  /// No description provided for @settingDisplay.
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get settingDisplay;

  /// No description provided for @settingTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingTheme;

  /// No description provided for @settingChooseTheme.
  ///
  /// In en, this message translates to:
  /// **'Choose Theme'**
  String get settingChooseTheme;

  /// No description provided for @settingLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingLight;

  /// No description provided for @settingDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingDark;

  /// No description provided for @settingSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingSystem;

  /// No description provided for @settingNotification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get settingNotification;

  /// No description provided for @settingNotificationUposathaReminder.
  ///
  /// In en, this message translates to:
  /// **'Uposatha Reminder'**
  String get settingNotificationUposathaReminder;

  /// No description provided for @settingMiscellaneous.
  ///
  /// In en, this message translates to:
  /// **'Miscellaneous'**
  String get settingMiscellaneous;

  /// No description provided for @settingAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingAbout;

  /// No description provided for @notificationUposatha.
  ///
  /// In en, this message translates to:
  /// **'Uposatha Reminder'**
  String get notificationUposatha;

  /// No description provided for @notificationUposathaDescription.
  ///
  /// In en, this message translates to:
  /// **'Let\'s do Uposatha Sila on Uposatha Day!'**
  String get notificationUposathaDescription;

  /// No description provided for @read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// No description provided for @fontSize.
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSize;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
