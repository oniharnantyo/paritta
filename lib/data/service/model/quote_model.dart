class QuoteModel {
  const QuoteModel({required this.quote, required this.source});

  final String quote;
  final String source;

  Map<String, dynamic> toJson() => {
        'quote': quote,
        'source': source,
      };

  QuoteModel.fromJson(Map<String, dynamic> json)
      : quote = json['quote'] as String,
        source = json['source'] as String;
}
