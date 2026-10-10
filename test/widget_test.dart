import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:utspm1/app.dart';
import 'package:utspm1/data/models/question.dart';
import 'package:utspm1/providers/quiz_provider.dart';
import 'package:utspm1/providers/theme_provider.dart';

const _questions = [
  Question(text: 'Q1', options: ['a', 'b'], correctIndex: 0),
  Question(text: 'Q2', options: ['a', 'b'], correctIndex: 1),
  Question(text: 'Q3', options: ['a', 'b'], correctIndex: 0),
];

void main() {
  group('QuizProvider', () {
    test('memilih jawaban dan menghitung skor', () {
      final quiz = QuizProvider(questions: _questions);
      quiz.selectAnswer(0); // benar
      quiz.next();
      quiz.selectAnswer(0); // salah
      quiz.next();
      // soal 3 tidak dijawab -> dihitung salah
      quiz.finish();

      expect(quiz.answeredCount, 2);
      expect(quiz.correctCount, 1);
      expect(quiz.wrongCount, 2);
      expect(quiz.score, 33);
      expect(quiz.isFinished, isTrue);
    });

    test('next/previous dibatasi pada batas soal', () {
      final quiz = QuizProvider(questions: _questions);
      quiz.previous();
      expect(quiz.currentIndex, 0);
      quiz.next();
      quiz.next();
      quiz.next();
      expect(quiz.currentIndex, 2);
      expect(quiz.isLast, isTrue);
    });

    test('jawaban tersimpan per soal saat pindah soal', () {
      final quiz = QuizProvider(questions: _questions);
      quiz.selectAnswer(1);
      quiz.next();
      quiz.previous();
      expect(quiz.selectedAnswer, 1);
    });

    test('reset mengembalikan keadaan awal', () {
      final quiz = QuizProvider(questions: _questions);
      quiz.selectAnswer(0);
      quiz.next();
      quiz.finish();
      quiz.reset();

      expect(quiz.currentIndex, 0);
      expect(quiz.answeredCount, 0);
      expect(quiz.isFinished, isFalse);
    });
  });

  group('ThemeProvider', () {
    test('toggle membalik tema yang sedang tampil', () {
      final theme = ThemeProvider();
      expect(theme.themeMode, ThemeMode.system);
      theme.toggle(Brightness.light);
      expect(theme.themeMode, ThemeMode.dark);
      theme.toggle(Brightness.dark);
      expect(theme.themeMode, ThemeMode.light);
    });
  });

  testWidgets('tombol toggle mengganti tema aplikasi', (tester) async {
    await tester.pumpWidget(const App());

    ThemeMode mode() =>
        tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode!;

    expect(mode(), ThemeMode.system);
    await tester.tap(find.byIcon(Icons.dark_mode_outlined));
    await tester.pump();
    expect(mode(), ThemeMode.dark);
  });
}
