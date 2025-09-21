import 'package:flutter/material.dart';
import '../models/question.dart';

// Sample quiz data
class QuizData {
  static final List<Map<String, dynamic>> _quizzes = [
    {
      'id': '1',
      'title': 'България - География',
      'description': 'Въпроси за географията на България',
      'category': 'geography',
      'difficulty': 'easy',
      'timePerQuestion': 30,
      'totalQuestions': 5,
      'questions': [
        Question(
          id: '1',
          text: 'Каква е столицата на България?',
          answers: [
            Answer(id: '1a', text: 'София', color: Colors.red),
            Answer(id: '1b', text: 'Пловдив', color: Colors.blue),
            Answer(id: '1c', text: 'Варна', color: Colors.yellow),
            Answer(id: '1d', text: 'Бургас', color: Colors.green),
          ],
          correctAnswerIndex: 0,
          timeLimit: 30,
        ),
        Question(
          id: '2',
          text: 'Кой е най-високият връх в България?',
          answers: [
            Answer(id: '2a', text: 'Мусала', color: Colors.red),
            Answer(id: '2b', text: 'Вихрен', color: Colors.blue),
            Answer(id: '2c', text: 'Рила', color: Colors.yellow),
            Answer(id: '2d', text: 'Пирин', color: Colors.green),
          ],
          correctAnswerIndex: 0,
          timeLimit: 30,
        ),
        Question(
          id: '3',
          text: 'Кой е най-дългият река в България?',
          answers: [
            Answer(id: '3a', text: 'Дунав', color: Colors.red),
            Answer(id: '3b', text: 'Марица', color: Colors.blue),
            Answer(id: '3c', text: 'Искър', color: Colors.yellow),
            Answer(id: '3d', text: 'Струма', color: Colors.green),
          ],
          correctAnswerIndex: 1,
          timeLimit: 30,
        ),
        Question(
          id: '4',
          text: 'Кой е най-големият град в България след София?',
          answers: [
            Answer(id: '4a', text: 'Пловдив', color: Colors.red),
            Answer(id: '4b', text: 'Варна', color: Colors.blue),
            Answer(id: '4c', text: 'Бургас', color: Colors.yellow),
            Answer(id: '4d', text: 'Русе', color: Colors.green),
          ],
          correctAnswerIndex: 0,
          timeLimit: 30,
        ),
        Question(
          id: '5',
          text: 'Кой е най-големият остров в България?',
          answers: [
            Answer(id: '5a', text: 'Свети Анастас', color: Colors.red),
            Answer(id: '5b', text: 'Свети Иван', color: Colors.blue),
            Answer(id: '5c', text: 'Свети Кирик', color: Colors.yellow),
            Answer(id: '5d', text: 'Свети Петър', color: Colors.green),
          ],
          correctAnswerIndex: 0,
          timeLimit: 30,
        ),
      ],
    },
    {
      'id': '2',
      'title': 'България - История',
      'description': 'Исторически въпроси за България',
      'category': 'history',
      'difficulty': 'medium',
      'timePerQuestion': 30,
      'totalQuestions': 5,
      'questions': [
        Question(
          id: '6',
          text: 'Кога е основана Първата българска държава?',
          answers: [
            Answer(id: '6a', text: '681 г.', color: Colors.red),
            Answer(id: '6b', text: '1185 г.', color: Colors.blue),
            Answer(id: '6c', text: '1878 г.', color: Colors.yellow),
            Answer(id: '6d', text: '1908 г.', color: Colors.green),
          ],
          correctAnswerIndex: 0,
          timeLimit: 30,
        ),
        Question(
          id: '7',
          text: 'Кой е първият български цар?',
          answers: [
            Answer(id: '7a', text: 'Аспарух', color: Colors.red),
            Answer(id: '7b', text: 'Борис I', color: Colors.blue),
            Answer(id: '7c', text: 'Симеон I', color: Colors.yellow),
            Answer(id: '7d', text: 'Петър I', color: Colors.green),
          ],
          correctAnswerIndex: 0,
          timeLimit: 30,
        ),
        Question(
          id: '8',
          text: 'Кога е приета първата българска конституция?',
          answers: [
            Answer(id: '8a', text: '1879 г.', color: Colors.red),
            Answer(id: '8b', text: '1908 г.', color: Colors.blue),
            Answer(id: '8c', text: '1947 г.', color: Colors.yellow),
            Answer(id: '8d', text: '1991 г.', color: Colors.green),
          ],
          correctAnswerIndex: 0,
          timeLimit: 30,
        ),
        Question(
          id: '9',
          text: 'Кой е наречен "Цар на българите и гърците"?',
          answers: [
            Answer(id: '9a', text: 'Симеон I', color: Colors.red),
            Answer(id: '9b', text: 'Борис I', color: Colors.blue),
            Answer(id: '9c', text: 'Петър I', color: Colors.yellow),
            Answer(id: '9d', text: 'Самуил', color: Colors.green),
          ],
          correctAnswerIndex: 0,
          timeLimit: 30,
        ),
        Question(
          id: '10',
          text: 'Кога е Освобождението на България?',
          answers: [
            Answer(id: '10a', text: '1878 г.', color: Colors.red),
            Answer(id: '10b', text: '1908 г.', color: Colors.blue),
            Answer(id: '10c', text: '1944 г.', color: Colors.yellow),
            Answer(id: '10d', text: '1989 г.', color: Colors.green),
          ],
          correctAnswerIndex: 0,
          timeLimit: 30,
        ),
      ],
    },
    {
      'id': '3',
      'title': 'България - Култура',
      'description': 'Културни въпроси за България',
      'category': 'culture',
      'difficulty': 'hard',
      'timePerQuestion': 30,
      'totalQuestions': 5,
      'questions': [
        Question(
          id: '11',
          text: 'Кой е авторът на "Под игото"?',
          answers: [
            Answer(id: '11a', text: 'Иван Вазов', color: Colors.red),
            Answer(id: '11b', text: 'Христо Ботев', color: Colors.blue),
            Answer(id: '11c', text: 'Пейо Яворов', color: Colors.yellow),
            Answer(id: '11d', text: 'Димчо Дебелянов', color: Colors.green),
          ],
          correctAnswerIndex: 0,
          timeLimit: 30,
        ),
        Question(
          id: '12',
          text: 'Кой е най-известният български композитор?',
          answers: [
            Answer(id: '12a', text: 'Панчо Владигеров', color: Colors.red),
            Answer(id: '12b', text: 'Добри Христов', color: Colors.blue),
            Answer(id: '12c', text: 'Емануил Манолов', color: Colors.yellow),
            Answer(id: '12d', text: 'Марин Големинов', color: Colors.green),
          ],
          correctAnswerIndex: 0,
          timeLimit: 30,
        ),
        Question(
          id: '13',
          text: 'Кой е най-известният български художник?',
          answers: [
            Answer(
                id: '13a',
                text: 'Владимир Димитров-Майстора',
                color: Colors.red),
            Answer(id: '13b', text: 'Николай Райнов', color: Colors.blue),
            Answer(id: '13c', text: 'Златю Бояджиев', color: Colors.yellow),
            Answer(id: '13d', text: 'Дечко Узунов', color: Colors.green),
          ],
          correctAnswerIndex: 0,
          timeLimit: 30,
        ),
        Question(
          id: '14',
          text: 'Кой е най-известният български актьор?',
          answers: [
            Answer(id: '14a', text: 'Георги Калоянчев', color: Colors.red),
            Answer(id: '14b', text: 'Стефан Данаилов', color: Colors.blue),
            Answer(id: '14c', text: 'Ицко Финци', color: Colors.yellow),
            Answer(id: '14d', text: 'Атанас Атанасов', color: Colors.green),
          ],
          correctAnswerIndex: 0,
          timeLimit: 30,
        ),
        Question(
          id: '15',
          text: 'Кой е най-известният български режисьор?',
          answers: [
            Answer(id: '15a', text: 'Рангел Вълчанов', color: Colors.red),
            Answer(id: '15b', text: 'Методи Андонов', color: Colors.blue),
            Answer(id: '15c', text: 'Бинка Желязкова', color: Colors.yellow),
            Answer(id: '15d', text: 'Людмил Стайков', color: Colors.green),
          ],
          correctAnswerIndex: 0,
          timeLimit: 30,
        ),
      ],
    },
  ];

  static List<Map<String, dynamic>> getQuizzes() {
    return _quizzes;
  }

  static Map<String, dynamic>? getQuizById(String id) {
    try {
      return _quizzes.firstWhere((quiz) => quiz['id'] == id);
    } catch (e) {
      return null;
    }
  }

  static List<Question> getQuizQuestions(String quizId) {
    final quiz = getQuizById(quizId);
    if (quiz != null) {
      return List<Question>.from(quiz['questions']);
    }
    return [];
  }

  static void addCustomQuiz(Map<String, dynamic> quiz) {
    _quizzes.add(quiz);
  }

  static void removeCustomQuiz(String quizId) {
    _quizzes.removeWhere((quiz) => quiz['id'] == quizId);
  }
}
