import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import '../models/question.dart';
import 'quiz_selection_screen.dart';

class CreateQuizScreen extends StatefulWidget {
  const CreateQuizScreen({super.key});

  @override
  State<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCategory = 'geography';
  String _selectedDifficulty = 'easy';
  int _timePerQuestion = 30;

  List<QuestionData> _questions = [];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Създай нова викторина',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Quiz Details Section
                          _buildQuizDetailsSection(),

                          const SizedBox(height: 24),

                          // Questions Section
                          _buildQuestionsSection(),

                          const SizedBox(height: 24),

                          // Action Buttons
                          _buildActionButtons(),
                        ],
                      ),
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

  Widget _buildQuizDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Детайли за викторината',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF7B2CBF),
              ),
        ),
        const SizedBox(height: 16),

        // Title Field
        TextFormField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: 'Заглавие на викторината',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.quiz),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Моля въведете заглавие';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        // Description Field
        TextFormField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            labelText: 'Описание (по избор)',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.description),
          ),
          maxLines: 2,
        ),

        const SizedBox(height: 16),

        // Category and Difficulty Row
        Row(
          children: [
            // Category Dropdown
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Категория',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: const [
                  DropdownMenuItem(
                      value: 'geography', child: Text('География')),
                  DropdownMenuItem(value: 'history', child: Text('История')),
                  DropdownMenuItem(value: 'culture', child: Text('Култура')),
                  DropdownMenuItem(value: 'science', child: Text('Наука')),
                  DropdownMenuItem(value: 'sports', child: Text('Спорт')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
            ),

            const SizedBox(width: 16),

            // Difficulty Dropdown
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _selectedDifficulty,
                decoration: const InputDecoration(
                  labelText: 'Трудност',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.speed),
                ),
                items: const [
                  DropdownMenuItem(value: 'easy', child: Text('Лесна')),
                  DropdownMenuItem(value: 'medium', child: Text('Средна')),
                  DropdownMenuItem(value: 'hard', child: Text('Трудна')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedDifficulty = value!;
                  });
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Time per Question
        Row(
          children: [
            const Icon(Icons.timer, color: Colors.grey),
            const SizedBox(width: 8),
            const Text('Време за отговор:'),
            const SizedBox(width: 16),
            Expanded(
              child: Slider(
                value: _timePerQuestion.toDouble(),
                min: 10,
                max: 120,
                divisions: 22,
                label: '${_timePerQuestion} секунди',
                onChanged: (value) {
                  setState(() {
                    _timePerQuestion = value.round();
                  });
                },
              ),
            ),
            Text('${_timePerQuestion}с'),
          ],
        ),
      ],
    );
  }

  Widget _buildQuestionsSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Въпроси (${_questions.length})',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF7B2CBF),
                    ),
              ),
              ElevatedButton.icon(
                onPressed: _addQuestion,
                icon: const Icon(Icons.add),
                label: const Text('Добави въпрос'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7B2CBF),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_questions.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.quiz_outlined,
                    size: 48,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Няма добавени въпроси',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Натиснете "Добави въпрос" за да започнете',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  final question = _questions[index];
                  return _buildQuestionCard(question, index);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(QuestionData question, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Въпрос ${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => _editQuestion(index),
                  icon: const Icon(Icons.edit, size: 20),
                ),
                IconButton(
                  onPressed: () => _deleteQuestion(index),
                  icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              question.text,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              'Правилен отговор: ${question.answers[question.correctAnswerIndex].text}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.green.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Отказ'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _questions.isNotEmpty ? _saveQuiz : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7B2CBF),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Запази викторината'),
          ),
        ),
      ],
    );
  }

  void _addQuestion() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddQuestionScreen(
          onQuestionAdded: (question) {
            setState(() {
              _questions.add(question);
            });
          },
        ),
      ),
    );
  }

  void _editQuestion(int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddQuestionScreen(
          question: _questions[index],
          questionIndex: index,
          onQuestionAdded: (question) {
            setState(() {
              _questions[index] = question;
            });
          },
        ),
      ),
    );
  }

  void _deleteQuestion(int index) {
    setState(() {
      _questions.removeAt(index);
    });
  }

  void _saveQuiz() {
    if (_formKey.currentState!.validate() && _questions.isNotEmpty) {
      // Convert QuestionData to Question objects
      final questions = _questions
          .map((q) => Question(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                text: q.text,
                answers: q.answers
                    .map((a) => Answer(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          text: a.text,
                          color: a.color,
                        ))
                    .toList(),
                correctAnswerIndex: q.correctAnswerIndex,
                timeLimit: _timePerQuestion,
              ))
          .toList();

      // Create new quiz
      final newQuiz = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'title': _titleController.text,
        'description': _descriptionController.text,
        'category': _selectedCategory,
        'difficulty': _selectedDifficulty,
        'timePerQuestion': _timePerQuestion,
        'totalQuestions': questions.length,
        'questions': questions,
      };

      // Add to quiz data
      QuizData.addCustomQuiz(newQuiz);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Викторината е създадена успешно!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back to quiz selection
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const QuizSelectionScreen(),
        ),
        (route) => false,
      );
    } else if (_questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Моля добавете поне един въпрос'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }
}

class QuestionData {
  String text;
  List<AnswerData> answers;
  int correctAnswerIndex;

  QuestionData({
    required this.text,
    required this.answers,
    required this.correctAnswerIndex,
  });
}

class AnswerData {
  String text;
  Color color;

  AnswerData({required this.text, required this.color});
}

class AddQuestionScreen extends StatefulWidget {
  final QuestionData? question;
  final int? questionIndex;
  final Function(QuestionData) onQuestionAdded;

  const AddQuestionScreen({
    super.key,
    this.question,
    this.questionIndex,
    required this.onQuestionAdded,
  });

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final List<AnswerData> _answers = [];
  int _correctAnswerIndex = 0;
  bool _isEditing = false;

  final List<Color> _answerColors = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.green,
  ];

  @override
  void initState() {
    super.initState();
    _isEditing = widget.question != null;
    if (_isEditing) {
      _questionController.text = widget.question!.text;
      _answers.addAll(widget.question!.answers);
      _correctAnswerIndex = widget.question!.correctAnswerIndex;
    } else {
      // Initialize with 4 empty answers
      for (int i = 0; i < 4; i++) {
        _answers.add(AnswerData(text: '', color: _answerColors[i]));
      }
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
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
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _isEditing ? 'Редактирай въпрос' : 'Добави въпрос',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Question Text
                          TextFormField(
                            controller: _questionController,
                            decoration: const InputDecoration(
                              labelText: 'Текст на въпроса',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.quiz),
                            ),
                            maxLines: 3,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Моля въведете текст на въпроса';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 24),

                          // Answers
                          Text(
                            'Отговори',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF7B2CBF),
                                ),
                          ),
                          const SizedBox(height: 16),

                          Expanded(
                            child: ListView.builder(
                              itemCount: _answers.length,
                              itemBuilder: (context, index) {
                                return _buildAnswerField(index);
                              },
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Save Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _saveQuestion,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF7B2CBF),
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: Text(_isEditing
                                  ? 'Запази промените'
                                  : 'Добави въпрос'),
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildAnswerField(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // Color indicator
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: _answers[index].color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),

          // Answer text field
          Expanded(
            child: TextFormField(
              initialValue: _answers[index].text,
              decoration: InputDecoration(
                labelText: 'Отговор ${index + 1}',
                border: const OutlineInputBorder(),
                suffixIcon: index == _correctAnswerIndex
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : IconButton(
                        icon: const Icon(Icons.radio_button_unchecked),
                        onPressed: () {
                          setState(() {
                            _correctAnswerIndex = index;
                          });
                        },
                      ),
              ),
              onChanged: (value) {
                _answers[index].text = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Моля въведете отговор';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  void _saveQuestion() {
    if (_formKey.currentState!.validate()) {
      // Check if at least one answer is filled
      bool hasValidAnswers = _answers.any((answer) => answer.text.isNotEmpty);
      if (!hasValidAnswers) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Моля въведете поне един отговор'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      // Filter out empty answers and create QuestionData
      final validAnswers =
          _answers.where((answer) => answer.text.isNotEmpty).toList();
      final correctAnswerIndex =
          validAnswers.indexOf(_answers[_correctAnswerIndex]);

      final question = QuestionData(
        text: _questionController.text,
        answers: validAnswers,
        correctAnswerIndex: correctAnswerIndex,
      );

      widget.onQuestionAdded(question);
      Navigator.of(context).pop();
    }
  }
}
