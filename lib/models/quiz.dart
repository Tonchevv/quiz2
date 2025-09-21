import 'package:flutter/material.dart';

class Quiz {
  final String id;
  final String title;
  final String description;
  final String category;
  final String difficultyLevel;
  final int timePerQuestion;
  final int totalQuestions;
  final DateTime createdAt;
  final String? createdBy;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficultyLevel,
    required this.timePerQuestion,
    required this.totalQuestions,
    required this.createdAt,
    this.createdBy,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      difficultyLevel: json['difficulty_level'] ?? 'easy',
      timePerQuestion: json['time_per_question'] ?? 30,
      totalQuestions: json['total_questions'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
      createdBy: json['created_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'difficulty_level': difficultyLevel,
      'time_per_question': timePerQuestion,
      'total_questions': totalQuestions,
      'created_at': createdAt.toIso8601String(),
      'created_by': createdBy,
    };
  }

  Color get difficultyColor {
    switch (difficultyLevel) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  String get difficultyText {
    switch (difficultyLevel) {
      case 'easy':
        return 'Лесен';
      case 'medium':
        return 'Среден';
      case 'hard':
        return 'Труден';
      default:
        return 'Неизвестен';
    }
  }
}

class QuizQuestion {
  final String id;
  final String quizId;
  final String questionText;
  final int questionOrder;
  final int timeLimit;
  final List<QuizAnswer> answers;

  QuizQuestion({
    required this.id,
    required this.quizId,
    required this.questionText,
    required this.questionOrder,
    required this.timeLimit,
    required this.answers,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json, List<QuizAnswer> answers) {
    return QuizQuestion(
      id: json['id'],
      quizId: json['quiz_id'],
      questionText: json['question_text'],
      questionOrder: json['question_order'],
      timeLimit: json['time_limit'] ?? 30,
      answers: answers,
    );
  }
}

class QuizAnswer {
  final String id;
  final String questionId;
  final String answerText;
  final bool isCorrect;
  final int answerOrder;
  final String colorCode;

  QuizAnswer({
    required this.id,
    required this.questionId,
    required this.answerText,
    required this.isCorrect,
    required this.answerOrder,
    required this.colorCode,
  });

  factory QuizAnswer.fromJson(Map<String, dynamic> json) {
    return QuizAnswer(
      id: json['id'],
      questionId: json['question_id'],
      answerText: json['answer_text'],
      isCorrect: json['is_correct'] ?? false,
      answerOrder: json['answer_order'],
      colorCode: json['color_code'] ?? 'blue',
    );
  }

  Color get color {
    switch (colorCode.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      case 'yellow':
        return Colors.yellow;
      default:
        return Colors.blue;
    }
  }
}

class QuizResult {
  final String id;
  final String userId;
  final String quizId;
  final int score;
  final int correctAnswers;
  final int wrongAnswers;
  final int totalQuestions;
  final double accuracy;
  final int? timeTaken;
  final DateTime completedAt;

  QuizResult({
    required this.id,
    required this.userId,
    required this.quizId,
    required this.score,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.totalQuestions,
    required this.accuracy,
    this.timeTaken,
    required this.completedAt,
  });

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      id: json['id'],
      userId: json['user_id'],
      quizId: json['quiz_id'],
      score: json['score'],
      correctAnswers: json['correct_answers'],
      wrongAnswers: json['wrong_answers'],
      totalQuestions: json['total_questions'],
      accuracy: (json['accuracy'] as num).toDouble(),
      timeTaken: json['time_taken'],
      completedAt: DateTime.parse(json['completed_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'quiz_id': quizId,
      'score': score,
      'correct_answers': correctAnswers,
      'wrong_answers': wrongAnswers,
      'total_questions': totalQuestions,
      'accuracy': accuracy,
      'time_taken': timeTaken,
      'completed_at': completedAt.toIso8601String(),
    };
  }
}
