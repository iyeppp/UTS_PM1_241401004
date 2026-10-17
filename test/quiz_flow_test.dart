import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:utspm1/app.dart';
import 'package:utspm1/core/constants/app_strings.dart';
import 'package:utspm1/data/dummy_questions.dart';

void main() {
  const sizes = {
    'HP portrait': Size(360, 740),
    'HP landscape': Size(740, 360),
    'tablet': Size(800, 1280),
  };

  for (final entry in sizes.entries) {
    testWidgets('alur Home-Kuis-Hasil di ${entry.key}', (tester) async {
      tester.view.physicalSize = entry.value;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(const App());
      await tester.ensureVisible(find.text(AppStrings.start));
      await tester.tap(find.text(AppStrings.start));
      await tester.pumpAndSettle();

      final total = dummyQuestions.length;
      for (var i = 0; i < total; i++) {
        await tester.ensureVisible(find.text('A'));
        await tester.tap(find.text('A'));
        await tester.pumpAndSettle();
        final label = i == total - 1 ? AppStrings.finish : AppStrings.next;
        await tester.tap(find.text(label));
        await tester.pumpAndSettle();
      }

      expect(find.text(AppStrings.retry), findsOneWidget);
      expect(find.text(AppStrings.scoreLabel), findsOneWidget);

      await tester.ensureVisible(find.text(AppStrings.backHome));
      await tester.tap(find.text(AppStrings.backHome));
      await tester.pumpAndSettle();
      expect(find.text(AppStrings.start), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
