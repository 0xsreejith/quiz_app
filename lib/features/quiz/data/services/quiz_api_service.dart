import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/features/quiz/data/models/question_model.dart';

class QuizApiService {
  static const String _baseUrl = 'https://opentdb.com/api.php';
  static const Duration _timeout = Duration(seconds: 10);

  Future<List<QuestionModel>> fetchQuestions({
    int amount = 10,
    int? categoryId,
    String? difficulty,
  }) async {
    final Map<String, String> params = <String, String>{
      'amount': amount.toString(),
      'type': 'multiple',
    };
    if (categoryId != null) params['category'] = categoryId.toString();
    if (difficulty != null) params['difficulty'] = difficulty;

    final Uri url = Uri.parse(_baseUrl).replace(queryParameters: params);
    final http.Response response = await http
        .get(url)
        .timeout(
          _timeout,
          onTimeout: () => throw Exception(
            'Request timed out. Check your internet connection.',
          ),
        );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load questions (HTTP ${response.statusCode}).',
      );
    }

    final Map<String, dynamic> body =
        json.decode(response.body) as Map<String, dynamic>;
    final int responseCode = body['response_code'] as int? ?? -1;
    switch (responseCode) {
      case 0:
        break;
      case 1:
        throw Exception(
          'Not enough questions in this category. Try a different one.',
        );
      case 5:
        throw Exception(
          'Too many requests. Please wait a moment and try again.',
        );
      default:
        throw Exception('API error (code $responseCode). Please try again.');
    }

    final List<dynamic> results = body['results'] as List<dynamic>;
    if (results.isEmpty) {
      throw Exception('No questions returned. Try a different category.');
    }
    return results
        .map((dynamic e) => QuestionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
