import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/home/controllers/home_controller.dart';
import 'package:quiz_app/features/home/data/models/category_model.dart';
import 'package:quiz_app/features/home/widgets/category_card.dart';
import 'package:quiz_app/features/home/widgets/top_performer_item.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF6366F1)),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionHeader(
                  title: 'Categories',
                  onSeeAll: () => controller.navigateToCategories(),
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.3,
                  ),
                  itemCount: TriviaCategories.all.length > 6
                      ? 6
                      : TriviaCategories.all.length,
                  itemBuilder: (context, index) {
                    final category = TriviaCategories.all[index];
                    return CategoryCard(
                      category: category,
                      onTap: () => controller.navigateToCategory(category),
                    );
                  },
                ),
                const SizedBox(height: 32),
                _SectionHeader(title: 'Top Performers', onSeeAll: () {}),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: controller.topPerformers.asMap().entries.map((
                      entry,
                    ) {
                      final performer = entry.value;
                      final isLast =
                          entry.key == controller.topPerformers.length - 1;
                      return Column(
                        children: [
                          TopPerformerItem(
                            performer: performer,
                            onTap: () =>
                                controller.navigateToProfile(performer.id),
                          ),
                          if (!isLast)
                            Divider(height: 1, color: Colors.grey[200]),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const _SectionHeader({required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: const Text(
            'See all',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6366F1),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
