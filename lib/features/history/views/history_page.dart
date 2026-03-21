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
              _buildTotalAccuracyCard(),
              AppSpacing.verticalLg,
              _buildQuizzesCompletedCard(),
              AppSpacing.verticalXxxl,
              const SectionHeader(title: 'RECENT ATTEMPTS'),
              AppSpacing.verticalLg,
              const AttemptCard(
                icon: Icons.terminal,
                iconColor: AppColors.darkNavy,
                iconBgColor: AppColors.chipBgBlue,
                level: 'EXPERT',
                levelColor: AppColors.emerald,
                levelBgColor: AppColors.chipBgGreen,
                date: 'OCT 24, 2023 • 14:30',
                title: 'Advanced Quantum\nComputing',
                subtitle: '18/20 Correct • 12m 45s Duration',
                score: '900',
                status: 'SYNCED',
                statusColor: AppColors.emerald,
                statusIcon: Icons.check_circle,
                actionText: 'VIEW ANALYSIS',
                actionColor: AppColors.darkNavy,
              ),
              AppSpacing.verticalLg,
              const AttemptCard(
                icon: Icons.psychology,
                iconColor: AppColors.indigo,
                iconBgColor: AppColors.chipBgSlate,
                level: 'INTERMEDIATE',
                levelColor: AppColors.indigoMid,
                levelBgColor: AppColors.chipBgBlue,
                date: 'OCT 23, 2023 • 09:12',
                title: 'Cognitive Behavioral\nLogic',
                subtitle: '14/20 Correct • 08m 12s Duration',
                score: '700',
                status: 'PENDING SYNC',
                statusColor: AppColors.darkNavy,
                statusIcon: Icons.cloud_upload,
                actionText: 'RETRY NOW',
                actionColor: AppColors.darkNavy,
                hasLeftBorder: true,
              ),
              AppSpacing.verticalLg,
              const AttemptCard(
                icon: Icons.architecture,
                iconColor: AppColors.darkNavy,
                iconBgColor: AppColors.chipBgBlue,
                level: 'BEGINNER',
                levelColor: AppColors.blueBright,
                levelBgColor: AppColors.chipBgLightBlue,
                date: 'OCT 22, 2023 • 18:45',
                title: 'Ancient Roman\nGovernance',
                subtitle: '08/20 Correct • 15m 02s Duration',
                score: '400',
                status: 'SYNCED',
                statusColor: AppColors.emerald,
                statusIcon: Icons.check_circle,
                actionText: 'REVIEW ERRORS',
                actionColor: AppColors.darkNavy,
              ),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      style: AppTextStyles.tinyBold(color: AppColors.darkNavy)
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
              Text('84%',
                  style: AppTextStyles.heroNumber(color: AppColors.darkNavy)),
              const SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.trending_up,
                        color: Colors.green.shade700, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '+2.4',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.bar_chart,
                    color: Colors.grey.shade300, size: 32),
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
                widthFactor: 0.84,
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
          Text('QUIZZES COMPLETED',
              style: AppTextStyles.miniLabel(color: Colors.white70)),
          AppSpacing.verticalLg,
          Text('128',
              style: AppTextStyles.heroNumber(color: Colors.white)),
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