import 'package:html_unescape/html_unescape.dart';

class QuestionModel {
  QuestionModel._({
    required this.question,
    required this.options,
    required int correctIndex,
  }) : _correctIndex = correctIndex;

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    final HtmlUnescape unescape = HtmlUnescape();
    final String correct = unescape.convert(json['correct_answer'] as String);
    final List<String> shuffled =
        (json['incorrect_answers'] as List<dynamic>)
            .map((dynamic e) => unescape.convert(e as String))
            .toList()
          ..add(correct)
          ..shuffle();

    return QuestionModel._(
      question: unescape.convert(json['question'] as String),
      options: shuffled,
      correctIndex: shuffled.indexOf(correct),
    );
  }

  final String question;
  final List<String> options;

  /// Index of the correct answer — private, never exposed to UI
  final int _correctIndex;

  /// Safe check used by the controller to validate an answer
  bool checkAnswer(String answer) => options[_correctIndex] == answer;

  /// Safe check used by the view — ONLY after [hasAnswered] is true
  bool isCorrectOption(String option) => options[_correctIndex] == option;
}
