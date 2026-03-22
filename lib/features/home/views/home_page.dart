import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/features/home/controllers/home_controller.dart';
import 'package:quiz_app/features/home/data/category_icons.dart';
import 'package:quiz_app/features/home/data/models/category_model.dart';
import 'package:quiz_app/features/home/widgets/category_card.dart';
import 'package:quiz_app/features/home/widgets/top_performer_item.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBg,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          return CustomScrollView(
            slivers: <Widget>[
              // ── Header ──
              SliverToBoxAdapter(child: _buildHeader()),

              // ── Search Bar ──
              SliverToBoxAdapter(child: _buildSearchBar()),

              // ── Quick Stats ──
              SliverToBoxAdapter(child: _buildQuickStats()),

              // ── Categories Section ──
              SliverToBoxAdapter(child: _buildCategoriesSection()),

              // ── Top Performers Section ──
              SliverToBoxAdapter(child: _buildTopPerformersSection()),

              // Bottom spacing
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          );
        }),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────
  // Header
  // ─────────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'Explore Quizzes',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDarkest,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Test your knowledge across categories',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x08000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.textDark,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────
  // Search Bar
  // ─────────────────────────────────────────────────────────────────────
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        height: AppSpacing.searchBarHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSpacing.searchBarRadius),
          border: Border.all(color: AppColors.searchBarBorder, width: 1),
        ),
        child: TextField(
          onChanged: (String value) => controller.searchQuery.value = value,
          style: const TextStyle(fontSize: 14, color: AppColors.textDark),
          decoration: const InputDecoration(
            hintText: 'Search categories',
            hintStyle: TextStyle(fontSize: 14, color: AppColors.textMuted),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: AppColors.textMuted,
              size: 20,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────
  // Quick Stats
  // ─────────────────────────────────────────────────────────────────────
  Widget _buildQuickStats() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: <Widget>[
          _StatChip(
            icon: Icons.grid_view_rounded,
            value: '${TriviaCategories.all.length}',
            label: 'Categories',
            color: AppColors.primary,
          ),
          const SizedBox(width: 12),
          const _StatChip(
            icon: Icons.emoji_events_outlined,
            value: '—',
            label: 'Top Score',
            color: Color(0xFFD4AF37),
          ),
          const SizedBox(width: 12),
          const _StatChip(
            icon: Icons.play_circle_outline,
            value: '—',
            label: 'Played',
            color: AppColors.accentGreen,
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────
  // Categories
  // ─────────────────────────────────────────────────────────────────────
  Widget _buildCategoriesSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Obx(() {
        final List<CategoryModel> categories = controller.filteredCategories;
        final bool isSearching = controller.searchQuery.value.trim().isNotEmpty;
        final int itemCount =
            isSearching ? categories.length : (categories.length > 6 ? 6 : categories.length);

        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDarkest,
                  ),
                ),
                if (!isSearching)
                  GestureDetector(
                    onTap: () => controller.navigateToCategories(),
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            if (categories.isEmpty)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: const Text(
                  'No categories found',
                  style: TextStyle(fontSize: 14, color: AppColors.textMuted),
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.4,
                ),
                itemCount: itemCount,
                itemBuilder: (BuildContext context, int index) {
                  final CategoryModel category = categories[index];
                  return CategoryCard(
                    category: category,
                    icon: CategoryIcons.forId(category.id),
                    onTap: () => controller.navigateToCategory(category),
                  );
                },
              ),
          ],
        );
      }),
    );
  }

  // ─────────────────────────────────────────────────────────────────────
  // Top Performers
  // ─────────────────────────────────────────────────────────────────────
  Widget _buildTopPerformersSection() {
    if (controller.topPerformers.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Top Performers',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDarkest,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: controller.topPerformers.asMap().entries.map((
                MapEntry<int, dynamic> entry,
              ) {
                final int index = entry.key;
                final performer = entry.value;
                final bool isLast =
                    index == controller.topPerformers.length - 1;
                return Column(
                  children: <Widget>[
                    TopPerformerItem(
                      performer: performer,
                      rank: index + 1,
                      onTap: () => controller.navigateToProfile(performer.id),
                    ),
                    if (!isLast)
                      Divider(
                        height: 1,
                        indent: 56,
                        endIndent: 16,
                        color: Colors.grey[200],
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Private helpers
// ═══════════════════════════════════════════════════════════════════════

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Icon(icon, size: 20, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textMuted,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
