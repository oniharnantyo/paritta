import 'package:paritta_app/domain/model/quote.dart';

abstract class QuoteRepository {
  Future<Quote> getTodayQuote();
}
