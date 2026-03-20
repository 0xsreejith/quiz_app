import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/features/quiz/data/models/question_model.dart';

class QuizApiService {
  static const String _baseUrl = 'https://opentdb.com/api.php';

  Future<List<QuestionModel>> fetchQuestions({int amount = 10}) async {
    final Uri url = Uri.parse('$_baseUrl?amount=$amount&type=multiple');
    final http.Response response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load questions (${response.statusCode})');
    }

    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;

    if (data['response_code'] != 0) {
      throw Exception('API returned error code: ${data['response_code']}');
    }

    final List<dynamic> results = data['results'] as List<dynamic>;
    return results
        .map(
          (dynamic e) =>
              QuestionModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }
}
