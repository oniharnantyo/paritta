import 'dart:math';

import 'package:paritta_app/data/service/model/today_quote_model.dart';
import 'package:paritta_app/data/service/quote_service.dart';
import 'package:paritta_app/domain/model/quote.dart';
import 'package:paritta_app/domain/repository/quote_repository.dart';

class LocalQuoteRepository extends QuoteRepository {
  LocalQuoteRepository({required this.quoteService});

  final QuoteService quoteService;

  @override
  Future<Quote> getTodayQuote() async {
    try {
      var todayQuote = await quoteService.getTodayQuote();
      if (todayQuote != null &&
          todayQuote.date.year == DateTime.now().year &&
          todayQuote.date.month == DateTime.now().month &&
          todayQuote.date.day == DateTime.now().day) {
        return Quote(
          quote: todayQuote.quote.quote,
          source: todayQuote.quote.source,
        );
      }

      final quotes = await quoteService.getQuotes();
      if (quotes.isEmpty) {
        throw Exception('No quotes available');
      }

      final randomIndex = Random().nextInt(quotes.length);
      final randomQuote = quotes[randomIndex];

      todayQuote = TodayQuoteModel(date: DateTime.now(), quote: randomQuote);
      await quoteService.saveTodayQuote(todayQuote);

      return Quote(
        quote: todayQuote.quote.quote,
        source: todayQuote.quote.source,
      );
    } catch (error) {
      rethrow;
    }
  }
}
