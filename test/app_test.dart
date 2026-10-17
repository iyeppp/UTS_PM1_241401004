import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:utspm1/app.dart';
import 'package:utspm1/core/constants/app_strings.dart';
import 'package:utspm1/data/dummy_questions.dart';
import 'package:utspm1/data/models/question.dart';
import 'package:utspm1/providers/quiz_provider.dart';
import 'package:utspm1/providers/theme_provider.dart';
import 'package:utspm1/screens/quiz_screen.dart';

const _questions = [
  Question(text: 'Q1', options: ['a', 'b'], correctIndex: 0),
  Question(text: 'Q2', options: ['a', 'b'], correctIndex: 1),
  Question(text: 'Q3', options: ['a', 'b'], correctIndex: 0),
];

Future<void> _tapText(WidgetTester tester, String text) async {
  await tester.ensureVisible(find.text(text));
  await tester.tap(find.text(text));
  await tester.pumpAndSettle();
}

void _setSize(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

void main() {
  group('QuizProvider', () {
    test('skor dihitung dari jawaban benar, kosong dihitung salah', () {
      final quiz = QuizProvider(questions: _questions);
      quiz.selectAnswer(0); // benar
      quiz.next();
      quiz.selectAnswer(0); // salah
      quiz.next(); // soal 3 tidak dijawab
      quiz.finish();

      expect(quiz.correctCount, 1);
      expect(quiz.wrongCount, 2);
      expect(quiz.score, 33);
      expect(quiz.isFinished, isTrue);
    });

    test('next/previous dibatasi dan jawaban tersimpan per soal', () {
      final quiz = QuizProvider(questions: _questions);
      quiz.previous();
      expect(quiz.currentIndex, 0);
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

  test('ThemeProvider.toggle membalik tema yang tampil', () {
    final theme = ThemeProvider();
    theme.toggle(Brightness.light);
    expect(theme.themeMode, ThemeMode.dark);
    theme.toggle(Brightness.dark);
    expect(theme.themeMode, ThemeMode.light);
  });

  const sizes = {
    'HP portrait': Size(360, 740),
    'HP landscape': Size(740, 360),
    'tablet': Size(800, 1280),
    'web/desktop': Size(1400, 900),
  };

  for (final entry in sizes.entries) {
    testWidgets('alur Home-Kuis-Hasil tanpa overflow di ${entry.key}', (
      tester,
    ) async {
      _setSize(tester, entry.value);
      await tester.pumpWidget(const App());
      await _tapText(tester, AppStrings.start);

      final total = dummyQuestions.length;
      for (var i = 0; i < total; i++) {
        await _tapText(tester, 'A');
        await _tapText(
          tester,
          i == total - 1 ? AppStrings.finish : AppStrings.next,
        );
      }
      expect(find.text(AppStrings.scoreLabel), findsOneWidget);

      await _tapText(tester, AppStrings.backHome);
      expect(find.text(AppStrings.start), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('state tahan rotasi, pindah halaman, dan ganti tema', (
    tester,
  ) async {
    _setSize(tester, const Size(400, 800));
    await tester.pumpWidget(const App());
    await _tapText(tester, AppStrings.start);
    await _tapText(tester, 'B');
    await _tapText(tester, AppStrings.next);

    QuizProvider quiz() => Provider.of<QuizProvider>(
      tester.element(find.byType(QuizScreen)),
      listen: false,
    );

    // rotasi
    tester.view.physicalSize = const Size(800, 400);
    await tester.pumpAndSettle();
    expect(quiz().currentIndex, 1);
    expect(quiz().answerAt(0), 1);

    // ganti tema
    await tester.tap(find.byIcon(Icons.dark_mode_outlined));
    await tester.pumpAndSettle();
    expect(quiz().currentIndex, 1);

    // keluar lewat dialog, lalu lanjutkan dari Home
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.exit));
    await tester.pumpAndSettle();
    await _tapText(tester, AppStrings.resume);
    expect(quiz().currentIndex, 1);
    expect(quiz().answerAt(0), 1);
  });
}
