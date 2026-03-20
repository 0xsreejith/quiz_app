import 'package:html_unescape/html_unescape.dart';

class QuestionModel {
  QuestionModel({
    required this.question,
    required this.correctAnswer,
    required this.options,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    final HtmlUnescape unescape = HtmlUnescape();
    final String correct = unescape.convert(json['correct_answer'] as String);
    final List<String> options = (json['incorrect_answers'] as List<dynamic>)
        .map((dynamic e) => unescape.convert(e as String))
        .toList()
      ..add(correct)
      ..shuffle();

    return QuestionModel(
      question: unescape.convert(json['question'] as String),
      correctAnswer: correct,
      options: options,
    );
  }

  final String question;
  final String correctAnswer;
  final List<String> options;
}
