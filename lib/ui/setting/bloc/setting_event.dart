part of 'setting_bloc.dart';

sealed class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

final class SettingAppConfigRequested extends SettingEvent {
  const SettingAppConfigRequested();
}

final class ThemeSaved extends SettingEvent {
  const ThemeSaved(this.theme);

  final ThemeMode theme;

  @override
  List<Object> get props => [theme];
}

final class LanguageSaved extends SettingEvent {
  const LanguageSaved(this.language);

  final Language language;

  @override
  List<Object> get props => [language];
}

final class NotificationUposathaReminderChanged extends SettingEvent {
  const NotificationUposathaReminderChanged(this.notificationUposathaReminder);

  final bool notificationUposathaReminder;

  @override
  List<Object> get props => [notificationUposathaReminder];
}
