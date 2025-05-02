class AppConfigModel {
  const AppConfigModel({required this.theme, required this.language});

  final String theme;
  final String language;

  AppConfigModel.fromJson(Map<String, dynamic> json)
      : theme = json['theme'] as String,
        language = json['language'] as String;

  Map<String, dynamic> toJson() => {'theme': theme, 'language': language};
}
