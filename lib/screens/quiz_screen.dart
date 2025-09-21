import 'dart:async';
import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import '../models/question.dart';
import 'results_screen.dart';
import 'score_entry_dialog.dart';

class QuizScreen extends StatefulWidget {
  final Map<String, dynamic> quiz;

  const QuizScreen({super.key, required this.quiz});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<Question> questions;
  int currentQuestionIndex = 0;
  int score = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;
  Timer? timer;
  int timeLeft = 30;
  bool answerSelected = false;
  int? selectedAnswerIndex;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadQuizQuestions();
  }

  Future<void> _loadQuizQuestions() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      final loadedQuestions = QuizData.getQuizQuestions(widget.quiz['id']);
      setState(() {
        questions = loadedQuestions;
        isLoading = false;
      });
      _startTimer();
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  void _startTimer() {
    timeLeft = widget.quiz['timePerQuestion'] ?? 30;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          timeLeft--;
        });

        if (timeLeft <= 0) {
          timer.cancel();
          _handleTimeUp();
        }
      }
    });
  }

  void _handleTimeUp() {
    if (!answerSelected) {
      setState(() {
        answerSelected = true;
        wrongAnswers++;
      });
      _showNextQuestion();
    }
  }

  void _selectAnswer(int index) {
    if (answerSelected) return;

    setState(() {
      answerSelected = true;
      selectedAnswerIndex = index;
    });

    timer?.cancel();

    if (index == questions[currentQuestionIndex].correctAnswerIndex) {
      setState(() {
        correctAnswers++;
        score += 10;
      });
    } else {
      setState(() {
        wrongAnswers++;
      });
    }

    _showNextQuestion();
  }

  void _showNextQuestion() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        if (currentQuestionIndex < questions.length - 1) {
          setState(() {
            currentQuestionIndex++;
            answerSelected = false;
            selectedAnswerIndex = null;
          });
          _startTimer();
        } else {
          _showResults();
        }
      }
    });
  }

  void _showResults() {
    if (mounted) {
      // Show score entry dialog first
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ScoreEntryDialog(
          score: score,
          correctAnswers: correctAnswers,
          totalQuestions: questions.length,
          quizTitle: widget.quiz['title'],
          category: widget.quiz['category'],
        ),
      ).then((_) {
        // After dialog is closed, show results screen
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ResultsScreen(
                score: score,
                correctAnswers: correctAnswers,
                wrongAnswers: wrongAnswers,
                totalQuestions: questions.length,
                quizTitle: widget.quiz['title'],
              ),
            ),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF7B2CBF), Color(0xFF9D4EDD), Color(0xFFC77DFF)],
            ),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                SizedBox(height: 16),
                Text(
                  'Зареждане на въпросите...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (error != null) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF7B2CBF), Color(0xFF9D4EDD), Color(0xFFC77DFF)],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Грешка при зареждане',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _loadQuizQuestions,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF7B2CBF),
                  ),
                  child: const Text('Опитайте отново'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final currentQuestion = questions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / questions.length;

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
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Quiz title
                    Text(
                      widget.quiz['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    // Progress bar
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.white.withOpacity(0.3),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white),
                            minHeight: 8,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '${currentQuestionIndex + 1}/${questions.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Timer
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.timer,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${timeLeft}с',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Question content
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        // Question
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7B2CBF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF7B2CBF).withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            currentQuestion.text,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF7B2CBF),
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Answers
                        Expanded(
                          child: ListView.builder(
                            itemCount: currentQuestion.answers.length,
                            itemBuilder: (context, index) {
                              final answer = currentQuestion.answers[index];
                              final isSelected = selectedAnswerIndex == index;
                              final isCorrect =
                                  index == currentQuestion.correctAnswerIndex;
                              final showAnswer =
                                  answerSelected && (isCorrect || isSelected);

                              Color backgroundColor = Colors.grey.shade100;
                              Color borderColor = Colors.grey.shade300;
                              Color textColor = Colors.black87;

                              if (showAnswer) {
                                if (isCorrect) {
                                  backgroundColor =
                                      Colors.green.withOpacity(0.1);
                                  borderColor = Colors.green;
                                  textColor = Colors.green.shade700;
                                } else if (isSelected && !isCorrect) {
                                  backgroundColor = Colors.red.withOpacity(0.1);
                                  borderColor = Colors.red;
                                  textColor = Colors.red.shade700;
                                }
                              }

                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () => _selectAnswer(index),
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: borderColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          // Color indicator
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: answer.color,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 16),

                                          // Answer text
                                          Expanded(
                                            child: Text(
                                              answer.text,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: textColor,
                                              ),
                                            ),
                                          ),

                                          // Selection indicator
                                          if (showAnswer)
                                            Icon(
                                              isCorrect
                                                  ? Icons.check_circle
                                                  : Icons.cancel,
                                              color: isCorrect
                                                  ? Colors.green
                                                  : Colors.red,
                                              size: 24,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
