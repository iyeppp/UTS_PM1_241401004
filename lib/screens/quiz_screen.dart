import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_strings.dart';
import '../core/router/app_router.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/option_tile.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_header.dart';
import '../widgets/question_card.dart';
import '../widgets/responsive_center.dart';
import '../widgets/theme_toggle_button.dart';

/// Halaman kuis: satu soal per layar dengan tombol sebelumnya/berikutnya.
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  /// Status tampilan opsi ke-[index]. Setelah dijawab, jawaban benar hijau
  /// dan jawaban salah yang dipilih merah.
  OptionState _stateFor(QuizProvider quiz, int index) {
    final selected = quiz.selectedAnswer;
    if (selected == null) return OptionState.idle;
    if (index == quiz.currentQuestion.correctIndex) return OptionState.correct;
    if (index == selected) return OptionState.wrong;
    return OptionState.idle;
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final quiz = context.watch<QuizProvider>();
    final question = quiz.currentQuestion;

    final questionCard = QuestionCard(
      number: quiz.currentIndex + 1,
      text: question.text,
    );

    final options = Column(
      children: [
        for (var i = 0; i < question.options.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: r.sm),
            child: OptionTile(
              letter: String.fromCharCode(65 + i),
              label: question.options[i],
              state: _stateFor(quiz, i),
              onTap: quiz.hasAnsweredCurrent
                  ? null
                  : () => quiz.selectAnswer(i),
            ),
          ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.quizTitle),
        actions: const [ThemeToggleButton()],
      ),
      body: SafeArea(
        child: ResponsiveCenter(
          child: Column(
            children: [
              ProgressHeader(
                current: quiz.currentIndex + 1,
                total: quiz.totalQuestions,
              ),
              SizedBox(height: r.md),
              Expanded(
                child: SingleChildScrollView(
                  child: r.useTwoColumns
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: questionCard),
                            SizedBox(width: r.md),
                            Expanded(child: options),
                          ],
                        )
                      : Column(
                          children: [
                            questionCard,
                            SizedBox(height: r.md),
                            options,
                          ],
                        ),
                ),
              ),
              SizedBox(height: r.sm),
              Row(
                children: [
                  if (!quiz.isFirst) ...[
                    Expanded(
                      child: PrimaryButton(
                        label: AppStrings.previous,
                        isOutlined: true,
                        onPressed: quiz.previous,
                      ),
                    ),
                    SizedBox(width: r.md),
                  ],
                  Expanded(
                    child: PrimaryButton(
                      label: quiz.isLast ? AppStrings.finish : AppStrings.next,
                      onPressed: !quiz.hasAnsweredCurrent
                          ? null
                          : quiz.isLast
                          ? () {
                              quiz.finish();
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.result,
                              );
                            }
                          : quiz.next,
                    ),
                  ),
                ],
              ),
              SizedBox(height: r.md),
            ],
          ),
        ),
      ),
    );
  }
}
