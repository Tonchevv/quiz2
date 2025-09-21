import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';
import '../models/quiz.dart';

class QuizService {
  static final SupabaseClient _supabase = SupabaseConfig.client;

  // Get all available quizzes
  static Future<List<Quiz>> getQuizzes() async {
    try {
      final response = await _supabase
          .from('quizzes')
          .select()
          .order('created_at', ascending: false);

      return (response as List).map((json) => Quiz.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Грешка при зареждане на викторините: $e');
    }
  }

  // Get quiz by ID
  static Future<Quiz> getQuizById(String quizId) async {
    try {
      final response =
          await _supabase.from('quizzes').select().eq('id', quizId).single();

      return Quiz.fromJson(response);
    } catch (e) {
      throw Exception('Грешка при зареждане на викторината: $e');
    }
  }

  // Get questions for a quiz
  static Future<List<QuizQuestion>> getQuizQuestions(String quizId) async {
    try {
      // Get questions
      final questionsResponse = await _supabase
          .from('questions')
          .select()
          .eq('quiz_id', quizId)
          .order('question_order');

      final questions = questionsResponse as List;

      // Get all answers for these questions
      final questionIds = questions.map((q) => q['id']).toList();
      final answersResponse = await _supabase
          .from('answers')
          .select()
          .inFilter('question_id', questionIds)
          .order('answer_order');

      final answers = answersResponse as List;

      // Group answers by question ID
      final answersByQuestion = <String, List<QuizAnswer>>{};
      for (final answer in answers) {
        final questionId = answer['question_id'];
        if (!answersByQuestion.containsKey(questionId)) {
          answersByQuestion[questionId] = [];
        }
        answersByQuestion[questionId]!.add(QuizAnswer.fromJson(answer));
      }

      // Create QuizQuestion objects
      return questions
          .map((q) => QuizQuestion.fromJson(
                q,
                answersByQuestion[q['id']] ?? [],
              ))
          .toList();
    } catch (e) {
      throw Exception('Грешка при зареждане на въпросите: $e');
    }
  }

  // Save quiz result
  static Future<void> saveQuizResult(QuizResult result) async {
    try {
      await _supabase.from('quiz_results').insert(result.toJson());
    } catch (e) {
      throw Exception('Грешка при запазване на резултата: $e');
    }
  }

  // Get user's quiz results
  static Future<List<QuizResult>> getUserQuizResults(String userId) async {
    try {
      final response = await _supabase.from('quiz_results').select('''
            *,
            quizzes:quiz_id (
              title,
              category
            )
          ''').eq('user_id', userId).order('completed_at', ascending: false);

      return (response as List)
          .map((json) => QuizResult.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Грешка при зареждане на резултатите: $e');
    }
  }

  // Get quiz statistics
  static Future<Map<String, dynamic>> getQuizStats(String quizId) async {
    try {
      final response = await _supabase
          .from('quiz_results')
          .select('score, accuracy, time_taken')
          .eq('quiz_id', quizId);

      if (response.isEmpty) {
        return {
          'totalAttempts': 0,
          'averageScore': 0.0,
          'averageAccuracy': 0.0,
          'averageTime': 0.0,
        };
      }

      final results = response as List;
      final totalAttempts = results.length;
      final averageScore =
          results.map((r) => r['score'] as int).reduce((a, b) => a + b) /
              totalAttempts;
      final averageAccuracy =
          results.map((r) => r['accuracy'] as num).reduce((a, b) => a + b) /
              totalAttempts;
      final averageTime = results
              .where((r) => r['time_taken'] != null)
              .map((r) => r['time_taken'] as int)
              .reduce((a, b) => a + b) /
          results.where((r) => r['time_taken'] != null).length;

      return {
        'totalAttempts': totalAttempts,
        'averageScore': averageScore,
        'averageAccuracy': averageAccuracy,
        'averageTime': averageTime,
      };
    } catch (e) {
      throw Exception('Грешка при зареждане на статистиките: $e');
    }
  }
}
