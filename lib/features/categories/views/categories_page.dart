import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/categories/controllers/categories_controller.dart';
import 'package:quiz_app/features/home/widgets/category_card.dart';

class CategoriesPage extends GetView<CategoriesController> {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Categories'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.5,
          ),
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final category = controller.categories[index];
            return CategoryCard(
              category: category,
              onTap: () => Get.toNamed(
                '/quiz',
                arguments: {
                  'categoryId': category.id,
                  'categoryName': category.name,
                  'categoryEmoji': category.emoji,
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
