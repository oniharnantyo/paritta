class AppConfigModel {
  const AppConfigModel({
    required this.theme,
    required this.language,
    required this.notificationUposathaReminder,
  });

  final String theme;
  final String language;
  final bool notificationUposathaReminder;

  AppConfigModel.fromJson(Map<String, dynamic> json)
      : theme = json['theme'] as String,
        language = json['language'] as String,
        notificationUposathaReminder =
            json['notificationUposathaReminder'] as bool? ?? false;

  Map<String, dynamic> toJson() => {
        'theme': theme,
        'language': language,
        'notificationUposathaReminder': notificationUposathaReminder
      };
}
