import 'package:flutter/widgets.dart';
import 'package:paritta_app/ui/core/i18n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
