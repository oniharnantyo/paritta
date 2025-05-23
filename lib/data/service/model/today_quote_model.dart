import 'package:paritta_app/data/service/model/quote_model.dart';

class TodayQuoteModel {
  const TodayQuoteModel({required this.date, required this.quote});

  final DateTime date;
  final QuoteModel quote;

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'quote': quote.toJson(),
      };

  TodayQuoteModel.fromJson(Map<String, dynamic> json)
      : date = DateTime.parse(json['date'] as String),
        quote = QuoteModel.fromJson(json['quote'] as Map<String, dynamic>);
}
