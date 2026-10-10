import 'package:flutter/foundation.dart';

import '../data/dummy_questions.dart';
import '../data/models/question.dart';

/// Menyimpan seluruh progres kuis: soal aktif, jawaban per soal, dan status
/// selesai. Diletakkan di atas `MaterialApp` sehingga tidak hilang saat
/// rotasi layar atau perpindahan halaman.
class QuizProvider extends ChangeNotifier {
  QuizProvider({List<Question> questions = dummyQuestions})
    : _questions = List.unmodifiable(questions),
      _answers = List<int?>.filled(questions.length, null);

  final List<Question> _questions;
  final List<int?> _answers;
  int _currentIndex = 0;
  bool _isFinished = false;

  // ---- Data soal ----
  List<Question> get questions => _questions;
  int get totalQuestions => _questions.length;
  int get currentIndex => _currentIndex;
  Question get currentQuestion => _questions[_currentIndex];

  // ---- Jawaban ----
  /// Jawaban terpilih pada soal [index], atau `null` jika belum dijawab.
  int? answerAt(int index) => _answers[index];
  int? get selectedAnswer => _answers[_currentIndex];
  bool get hasAnsweredCurrent => selectedAnswer != null;
  int get answeredCount => _answers.where((a) => a != null).length;
  bool get allAnswered => answeredCount == totalQuestions;

  // ---- Navigasi soal ----
  bool get isFirst => _currentIndex == 0;
  bool get isLast => _currentIndex == totalQuestions - 1;

  // ---- Hasil ----
  bool get isFinished => _isFinished;
  int get correctCount {
    var count = 0;
    for (var i = 0; i < totalQuestions; i++) {
      if (_questions[i].isCorrect(_answers[i])) count++;
    }
    return count;
  }

  /// Soal yang tidak dijawab dihitung salah.
  int get wrongCount => totalQuestions - correctCount;
  int get score =>
      totalQuestions == 0 ? 0 : (correctCount * 100 ~/ totalQuestions);

  /// Progres 0.0 - 1.0 berdasarkan posisi soal aktif.
  double get progress =>
      totalQuestions == 0 ? 0 : (_currentIndex + 1) / totalQuestions;

  // ---- Aksi ----
  void selectAnswer(int optionIndex) {
    if (_isFinished) return;
    if (optionIndex < 0 || optionIndex >= currentQuestion.options.length) {
      return;
    }
    _answers[_currentIndex] = optionIndex;
    notifyListeners();
  }

  void next() {
    if (isLast) return;
    _currentIndex++;
    notifyListeners();
  }

  void previous() {
    if (isFirst) return;
    _currentIndex--;
    notifyListeners();
  }

  void goTo(int index) {
    if (index < 0 || index >= totalQuestions || index == _currentIndex) return;
    _currentIndex = index;
    notifyListeners();
  }

  void finish() {
    if (_isFinished) return;
    _isFinished = true;
    notifyListeners();
  }

  void reset() {
    _currentIndex = 0;
    _isFinished = false;
    _answers.fillRange(0, _answers.length, null);
    notifyListeners();
  }
}
