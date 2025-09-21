import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'quiz_selection_screen.dart';

class ResultsScreen extends StatelessWidget {
  final int score;
  final int correctAnswers;
  final int wrongAnswers;
  final int totalQuestions;
  final String? quizTitle;

  const ResultsScreen({
    super.key,
    required this.score,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.totalQuestions,
    this.quizTitle,
  });

  double get accuracy =>
      totalQuestions > 0 ? (correctAnswers / totalQuestions) * 100 : 0;

  String get performanceMessage {
    if (accuracy >= 90) return 'Отлично! 🎉';
    if (accuracy >= 70) return 'Много добре! 👏';
    if (accuracy >= 50) return 'Добре! 👍';
    return 'Опитай отново! 💪';
  }

  Color get performanceColor {
    if (accuracy >= 90) return Colors.green;
    if (accuracy >= 70) return Colors.blue;
    if (accuracy >= 50) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF7B2CBF), Color(0xFF9D4EDD), Color(0xFFC77DFF)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Results Title
                Text(
                  '🎉 Резултати',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 42,
                      ),
                ).animate().fadeIn(duration: 600.ms).scale(),

                if (quizTitle != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    quizTitle!,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                  ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
                ],

                const SizedBox(height: 32),

                // Performance Message
                Text(
                  performanceMessage,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: performanceColor,
                        fontWeight: FontWeight.bold,
                      ),
                ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

                const SizedBox(height: 48),

                // Score Circle
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 4,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$score',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'точки',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 400.ms, duration: 800.ms).scale(),

                const SizedBox(height: 48),

                // Statistics Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      _buildStatRow(
                        'Правилни отговори:',
                        '$correctAnswers',
                        Icons.check_circle,
                        Colors.green,
                      ),
                      const SizedBox(height: 16),
                      _buildStatRow(
                        'Неправилни отговори:',
                        '$wrongAnswers',
                        Icons.cancel,
                        Colors.red,
                      ),
                      const SizedBox(height: 16),
                      _buildStatRow(
                        'Общо въпроси:',
                        '$totalQuestions',
                        Icons.quiz,
                        Colors.blue,
                      ),
                      const SizedBox(height: 16),
                      _buildStatRow(
                        'Точност:',
                        '${accuracy.toStringAsFixed(1)}%',
                        Icons.trending_up,
                        performanceColor,
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 600.ms, duration: 600.ms).slideY(),

                const SizedBox(height: 48),

                // Action Buttons
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const QuizSelectionScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF7B2CBF),
                          elevation: 8,
                          shadowColor: Colors.black.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: Text(
                          'Избери друга викторина',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton(
                        onPressed: () {
                          // TODO: Implement share functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Функцията за споделяне ще бъде добавена скоро!',
                              ),
                              backgroundColor: Colors.blue,
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: Text(
                          'Сподели резултата',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 800.ms, duration: 600.ms).slideY(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, IconData icon, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
