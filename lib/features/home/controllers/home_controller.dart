import 'package:get/get.dart';
import 'package:quiz_app/core/services/api_service.dart';
import 'package:quiz_app/features/home/data/models/category_model.dart';
import 'package:quiz_app/features/home/data/models/home_models.dart';
import 'package:quiz_app/routes/app_routes.dart';

class HomeController extends GetxController {
  final RxList<TopPerformer> topPerformers = <TopPerformer>[].obs;
  final RxBool isLoading = true.obs;
  final RxString searchQuery = ''.obs;

  List<CategoryModel> get filteredCategories {
    final String query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) return TriviaCategories.all;
    return TriviaCategories.all
        .where((CategoryModel c) => c.name.toLowerCase().contains(query))
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    loadTopPerformers();
  }

  Future<void> loadTopPerformers() async {
    try {
      isLoading(true);
      final response = await ApiService.getTopPerformers();
      if (response['success'] == true) {
        final List<dynamic> data = response['data'];
        topPerformers.value = data
            .map((item) => TopPerformer.fromJson(item))
            .toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load data');
    } finally {
      isLoading(false);
    }
  }

  void navigateToProfile(String userId) {
    Get.toNamed('/profile', arguments: userId);
  }

  void navigateToCategory(CategoryModel category) {
    Get.toNamed(
      AppRoutes.quiz,
      arguments: {
        'categoryId': category.id,
        'categoryName': category.name,
        'categoryEmoji': category.emoji,
      },
    );
  }

  void navigateToCategories() {
    Get.toNamed(AppRoutes.categories);
  }
}
