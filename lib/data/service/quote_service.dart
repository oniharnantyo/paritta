import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:paritta_app/data/service/model/quote_model.dart';
import 'package:paritta_app/data/service/model/today_quote_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuoteService {
  QuoteService({required this.sharedPreferences});

  final SharedPreferencesAsync sharedPreferences;

  final Logger _log = Logger('QuoteService');

  Future<List<QuoteModel>> getQuotes() async {
    try {
      final data = await rootBundle.loadString('assets/json/quotes.json');
      final quotesJson = jsonDecode(data) as List<dynamic>;

      return quotesJson
          .map((quoteJson) =>
              QuoteModel.fromJson(quoteJson as Map<String, dynamic>))
          .toList();
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  Future<TodayQuoteModel?> getTodayQuote() async {
    try {
      final todayQuoteJson = await sharedPreferences.getString('todayQuote');
      if (todayQuoteJson == null) {
        return null;
      }

      final todayQuote = TodayQuoteModel.fromJson(
          jsonDecode(todayQuoteJson!) as Map<String, dynamic>);

      return todayQuote;
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  Future<void> saveTodayQuote(TodayQuoteModel todayQuote) async {
    try {
      final todayQuoteJson = jsonEncode(todayQuote);
      await sharedPreferences.setString('todayQuote', todayQuoteJson);
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }
}
