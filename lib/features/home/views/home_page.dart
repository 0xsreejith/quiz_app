import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';
import 'package:quiz_app/core/utils/home_helpers.dart';
import 'package:quiz_app/core/widgets/carousel_indicator.dart';
import 'package:quiz_app/core/widgets/category_panel.dart';
import 'package:quiz_app/core/widgets/featured_quiz_carousel.dart';
import 'package:quiz_app/core/widgets/home_search_bar.dart';
import 'package:quiz_app/core/widgets/live_session_card.dart';
import 'package:quiz_app/core/widgets/recent_activity_card.dart';
import 'package:quiz_app/core/widgets/section_title_row.dart';
import 'package:quiz_app/core/widgets/top_performers_card.dart';
import 'package:quiz_app/features/home/controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showCategories = false;
  int _carouselPage = 0;

  // Safe lazy getter — finds the controller only when actually needed,
  // avoiding LateInitializationError if the controller isn't yet registered
  // at initState time.
  HomeController get _controller => Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceWhite,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // ── Search Bar ──
            Padding(
              padding: AppSpacing.homePagePadding,
              child: HomeSearchBar(
                onTap: () => setState(() {
                  _showCategories = !_showCategories;
                }),
              ),
            ),

            // ── Category Panel (toggle) ──
            if (_showCategories)
              Padding(
                padding: AppSpacing.homePagePadding,
                child: const CategoryPanel(),
              ),

            SizedBox(height: AppSpacing.sectionGap),

            // ── Featured Quizzes Header ──
            Padding(
              padding: AppSpacing.homePagePadding,
              child: SectionTitleRow(
                label: 'RECOMMENDED FOR YOU',
                title: 'Featured Quizzes',
                trailing: CarouselIndicator(
                  count: HomeHelpers.featuredQuizzes.length,
                  currentIndex: _carouselPage,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ── Featured Quiz Carousel ──
            FeaturedQuizCarousel(
              quizzes: HomeHelpers.featuredQuizzes,
              onStartQuiz: _controller.startQuiz,
              onPageChanged: (index) =>
                  setState(() => _carouselPage = index),
            ),

            SizedBox(height: AppSpacing.sectionGap),

            // ── Live Sessions Section ──
            Padding(
              padding: AppSpacing.homePagePadding,
              child: SectionTitleRow(
                label: '',
                title: 'Live Sessions',
                trailing: _buildLiveBadge(),
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: AppSpacing.homePagePadding,
              child: LiveSessionCard(
                title: HomeHelpers.liveSession['title']!,
                startsIn: HomeHelpers.liveSession['startsIn']!,
                waiting: HomeHelpers.liveSession['waiting']!,
              ),
            ),

            SizedBox(height: AppSpacing.sectionGap),

            // ── Top Performers Section ──
            Padding(
              padding: AppSpacing.homePagePadding,
              child: const SectionTitleRow(
                label: '',
                title: 'Top Performers',
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: AppSpacing.homePagePadding,
              child: TopPerformersCard(
                performers: HomeHelpers.topPerformers,
              ),
            ),

            SizedBox(height: AppSpacing.sectionGap),

            // ── Recent Activity Section ──
            Padding(
              padding: AppSpacing.homePagePadding,
              child: const SectionTitleRow(
                label: '',
                title: 'Recent Activity',
              ),
            ),
            const SizedBox(height: 14),

            // Uses copyWith() on a cast EdgeInsets to safely add bottom
            // spacing — avoids calling .add() on abstract EdgeInsetsGeometry.
            ...HomeHelpers.recentActivities.map(
              (a) => Padding(
                padding: (AppSpacing.homePagePadding as EdgeInsets)
                    .copyWith(bottom: 12),
                child: RecentActivityCard(
                  title: a['title']!,
                  meta: a['meta']!,
                  accuracy: a['accuracy']!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// LIVE NOW badge for the Live Sessions section header.
  Widget _buildLiveBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        // Fixed: replaced invalid .withValues(alpha:) with .withOpacity()
        color: AppColors.liveBadgeRed.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.liveBadgeRed,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            'LIVE NOW',
            style: AppTextStyles.tinyBold(color: AppColors.liveBadgeRed),
          ),
        ],
      ),
    );
  }
}