import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';
import 'package:quiz_app/core/widgets/attempt_card.dart';
import 'package:quiz_app/core/widgets/footer_section.dart';
import 'package:quiz_app/core/widgets/section_header.dart';
import 'package:quiz_app/features/history/controllers/history_controller.dart';

class HistoryPage extends GetView<HistoryController> {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.historyBg,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.historyPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              AppSpacing.verticalXxl,
              Obx(() => _buildTotalAccuracyCard()),
              AppSpacing.verticalLg,
              Obx(() => _buildQuizzesCompletedCard()),
              AppSpacing.verticalXxxl,
              const SectionHeader(title: 'RECENT ATTEMPTS'),
              AppSpacing.verticalLg,
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  );
                }

                if (controller.errorMessage.value.isNotEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(
                            Icons.error_outline,
                            color: AppColors.textMuted,
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Unable to load data',
                            style: AppTextStyles.cardTitle,
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: controller.refreshHistory,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (controller.quizHistory.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.inbox_outlined,
                            color: AppColors.textMuted,
                            size: 48,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No attempts yet',
                            style: AppTextStyles.cardTitle,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Complete a quiz to see your results here',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Column(
                  children: controller.quizHistory.map((
                    Map<String, dynamic> history,
                  ) {
                    final int accuracy = history['accuracy'] as int? ?? 0;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: AttemptCard(
                        icon: Icons.quiz_outlined,
                        iconColor: AppColors.darkNavy,
                        iconBgColor: AppColors.chipBgBlue,
                        level: accuracy >= 90
                            ? 'EXPERT'
                            : accuracy >= 70
                            ? 'INTERMEDIATE'
                            : 'BEGINNER',
                        levelColor: accuracy >= 90
                            ? AppColors.emerald
                            : accuracy >= 70
                            ? AppColors.indigoMid
                            : AppColors.blueBright,
                        levelBgColor: accuracy >= 90
                            ? AppColors.chipBgGreen
                            : accuracy >= 70
                            ? AppColors.chipBgBlue
                            : AppColors.chipBgLightBlue,
                        date: _formatDate(history['playedAt']),
                        title:
                            '${history['categoryEmoji'] ?? '📝'} ${history['categoryName'] ?? 'Quiz'}',
                        subtitle:
                            '${history['correctAnswers'] ?? 0}/${history['totalQuestions'] ?? 0} Correct',
                        score: '${history['score'] ?? 0} pts',
                        status: 'SYNCED',
                        statusColor: AppColors.emerald,
                        statusIcon: Icons.check_circle,
                        actionText: 'VIEW DETAILS',
                        actionColor: AppColors.darkNavy,
                      ),
                    );
                  }).toList(),
                );
              }),
              const SizedBox(height: 48),
              const FooterSection(
                title: 'END OF TRANSMISSION',
                subtitle:
                    'Historical data is archived every 30 days.\nContact admin for deeper logs.',
              ),
              AppSpacing.verticalXxl,
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(dynamic timestamp) {
    if (timestamp == null) return 'JUST NOW';
    if (timestamp is Timestamp) {
      final DateTime dt = timestamp.toDate();
      const List<String> months = <String>[
        'JAN',
        'FEB',
        'MAR',
        'APR',
        'MAY',
        'JUN',
        'JUL',
        'AUG',
        'SEP',
        'OCT',
        'NOV',
        'DEC',
      ];
      return '${months[dt.month - 1]} ${dt.day}, ${dt.year} • ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    }
    return '';
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ACTIVITY LOGS', style: AppTextStyles.miniLabel()),
        AppSpacing.verticalSm,
        const Text('History', style: AppTextStyles.pageTitleLarge),
        AppSpacing.verticalXl,
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Text(
                      'ALL',
                      style: AppTextStyles.tinyBold(
                        color: AppColors.darkNavy,
                      ).copyWith(fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      'SYNCED',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.deepNavy,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Row(
                children: [
                  Icon(Icons.sync, color: Colors.white, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'RETRY SYNC',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTotalAccuracyCard() {
    return Container(
      padding: AppSpacing.cardPaddingLarge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('TOTAL ACCURACY', style: AppTextStyles.miniLabel()),
          AppSpacing.verticalLg,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${controller.avgAccuracyStat.value}%',
                style: AppTextStyles.heroNumber(color: AppColors.darkNavy),
              ),
              const Spacer(),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.bar_chart,
                  color: Colors.grey.shade300,
                  size: 32,
                ),
              ),
            ],
          ),
          AppSpacing.verticalXxl,
          Stack(
            children: [
              Container(
                height: 4,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              FractionallySizedBox(
                widthFactor: (controller.avgAccuracyStat.value / 100)
                    .clamp(0.0, 1.0)
                    .toDouble(),
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.darkNavy,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuizzesCompletedCard() {
    return Container(
      padding: AppSpacing.cardPaddingLarge,
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'QUIZZES COMPLETED',
            style: AppTextStyles.miniLabel(color: Colors.white70),
          ),
          AppSpacing.verticalLg,
          Text(
            '${controller.totalPlayedStat.value}',
            style: AppTextStyles.heroNumber(color: Colors.white),
          ),
          AppSpacing.verticalXxl,
          Text(
            'PRODUCTION GRADE PERFORMANCE MONITORING ACTIVE',
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
