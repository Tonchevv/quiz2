import 'package:flutter/material.dart';

class Question {
  final String id;
  final String text;
  final List<Answer> answers;
  final int correctAnswerIndex;
  final int timeLimit; // in seconds

  Question({
    required this.id,
    required this.text,
    required this.answers,
    required this.correctAnswerIndex,
    this.timeLimit = 30,
  });
}

class Answer {
  final String id;
  final String text;
  final Color color;

  Answer({required this.id, required this.text, required this.color});
}

class QuizResult {
  final int score;
  final int correctAnswers;
  final int wrongAnswers;
  final int totalQuestions;
  final double accuracy;

  QuizResult({
    required this.score,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.totalQuestions,
    required this.accuracy,
  });
}
