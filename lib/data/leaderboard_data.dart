import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderboardData {
  static const String _leaderboardKey = 'leaderboard_scores';

  // Get all leaderboard entries
  static Future<List<LeaderboardEntry>> getLeaderboard() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? leaderboardJson = prefs.getString(_leaderboardKey);

      if (leaderboardJson == null) {
        return [];
      }

      final List<dynamic> leaderboardList = json.decode(leaderboardJson);
      return leaderboardList
          .map((json) => LeaderboardEntry.fromJson(json))
          .toList()
        ..sort(
            (a, b) => b.score.compareTo(a.score)); // Sort by score descending
    } catch (e) {
      return [];
    }
  }

  // Add a new score to leaderboard
  static Future<void> addScore(LeaderboardEntry entry) async {
    try {
      final List<LeaderboardEntry> currentLeaderboard = await getLeaderboard();
      currentLeaderboard.add(entry);

      // Sort by score descending
      currentLeaderboard.sort((a, b) => b.score.compareTo(a.score));

      // Keep only top 100 scores
      if (currentLeaderboard.length > 100) {
        currentLeaderboard.removeRange(100, currentLeaderboard.length);
      }

      final prefs = await SharedPreferences.getInstance();
      final String leaderboardJson = json.encode(
        currentLeaderboard.map((entry) => entry.toJson()).toList(),
      );
      await prefs.setString(_leaderboardKey, leaderboardJson);
    } catch (e) {
      // Handle error silently
    }
  }

  // Get leaderboard by category
  static Future<List<LeaderboardEntry>> getLeaderboardByCategory(
      String category) async {
    final allEntries = await getLeaderboard();
    if (category == 'all') {
      return allEntries;
    }
    return allEntries.where((entry) => entry.category == category).toList();
  }

  // Clear all leaderboard data
  static Future<void> clearLeaderboard() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_leaderboardKey);
    } catch (e) {
      // Handle error silently
    }
  }
}

class LeaderboardEntry {
  final String id;
  final String playerName;
  final int score;
  final String quizTitle;
  final String category;
  final DateTime completedAt;
  final int correctAnswers;
  final int totalQuestions;
  final double accuracy;

  LeaderboardEntry({
    required this.id,
    required this.playerName,
    required this.score,
    required this.quizTitle,
    required this.category,
    required this.completedAt,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.accuracy,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'playerName': playerName,
      'score': score,
      'quizTitle': quizTitle,
      'category': category,
      'completedAt': completedAt.toIso8601String(),
      'correctAnswers': correctAnswers,
      'totalQuestions': totalQuestions,
      'accuracy': accuracy,
    };
  }

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      id: json['id'],
      playerName: json['playerName'],
      score: json['score'],
      quizTitle: json['quizTitle'],
      category: json['category'],
      completedAt: DateTime.parse(json['completedAt']),
      correctAnswers: json['correctAnswers'],
      totalQuestions: json['totalQuestions'],
      accuracy: json['accuracy'].toDouble(),
    );
  }
}
