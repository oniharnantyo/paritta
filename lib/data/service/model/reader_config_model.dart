class ReaderConfigModel {
  const ReaderConfigModel({required this.fontSize});

  final double fontSize;

  Map<String, dynamic> toJson() => {'fontSize': fontSize};

  ReaderConfigModel.fromJson(Map<String, dynamic> json)
      : fontSize = json['fontSize'] as double;
}
